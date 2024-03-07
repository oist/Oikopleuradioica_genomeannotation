#!/bin/Rscript

library(optparse)      |> suppressPackageStartupMessages()
library(S4Vectors)     |> suppressPackageStartupMessages()
library(GenomicRanges) |> suppressPackageStartupMessages()
library(rtracklayer)   |> suppressPackageStartupMessages()

option_list = list(
	# Input options
	make_option(c('-n', '--speciesName'), action='store', default=NA, type='character',
		help='String reporting species name. Must exactly match a column in the OrthoFinder output. Default: none'),
	make_option(c('-f', '--orthoFinder'), action='store', default=NA, type='character',
		help='OrthoFinder TSV output file containing HOG and OG annotations. Default: none'),
	make_option(c('-g', '--gff'), action='store', default=NA, type='character',
		help='Annotation GFF file to add orthogroup annotations to. Default: none'),

	# Output options
	make_option(c('-o', '--output'), action='store', default=NA, type='character',
		help='Base name to use for output files (i.e., a gff3-formatted annotation file with orthogroup annotations added). Default: [genomeName]_orthofinder.gff')
)

opt = parse_args(OptionParser(option_list=option_list))

# Make sure a string corresponding to genome name is provided.
if(is.na(opt$speciesName)){
	cat('Error: an input genome name must be provided with -n or --speciesName.\n', file=stderr())
	quit(status=1)
}

# Make sure an orthofinder TSV file is provided.
if(is.na(opt$orthoFinder)){
	cat('Error: an input OrthoFinder table in TSV format must be provided with -f or --orthoFinder.\n', file=stderr())
	quit(status=1)
}

# Make sure an annotation GFF file is provided.
if(is.na(opt$gff)){
	cat('Error: an input gene annotation file in GFF3 format must be provided with -g or --gff.\n', file=stderr())
	quit(status=1)
}

# Check output basename, or else make one up.
if(is.na(opt$output)){
	output_basename <- unlist(strsplit(basename(opt$gff), '.gff'))[1]
	output_basename <- paste0(output_basename, '_orthofinder.gff3')
} else {
	output_basename <- opt$output
}

####################################################################
#
# Helper functions. Parsing, etc. 
#
####################################################################

read_annotation_gff <- function(i_gff, chr_of_interest=NULL) {
	gff <- rtracklayer::import.gff3(i_gff)
	gff
}


read_orthofinder <- function(i_of) {
	i_of <- read.delim(i_of, sep='\t')
	# Replace empty strings with NA
	i_of[i_of==""] <- NA
	# Remove all-NA columns.
	i_of <- i_of[,which(!apply(i_of, 2, \(x) all(is.na(x))))]
	# Get species names from OrthoFinder columns.
	species_names <- colnames(i_of)[which( ! colnames(i_of) %in% c('HOG', 'OG', 'Gene.Tree.Parent.Clade') )]
	
	# Return a long-formatted data.frame for every species.
	of_by_sp <- lapply(species_names, function(sp) {
		# Include all OGs and HOGs.
		sp_df <- data.frame(OG=i_of$OG, HOG=i_of$HOG)
		sp_df$IDs <- unlist(i_of[[sp]])
		# Exclude orthogroups with NAs for that species.
		sp_df <- sp_df[!is.na(sp_df$IDs),]
		# Break apart ID list
		sp_df$IDs_split <- strsplit(sp_df$IDs, ', ')
		# Create a new table for each HOG.
		sp_df_long <- lapply(1:nrow(sp_df), \(x) {
			data.frame(OG=sp_df$OG[x], HOG=sp_df$HOG[x], ID=sp_df$IDs_split[[x]])
		})
		sp_df_long <- do.call(rbind, sp_df_long)
		sp_df_long
	})
	names(of_by_sp) <- species_names
	of_by_sp
}


check_match_between_of_gff <- function(of_ids, gff_gr, match_type='transcript', digits=2) {
	unique_gff_ids <- unique(gff_gr$ID)
	# IDs from OrthoFinder also in GFF.
	of_matches <- which(of_ids %in% unique_gff_ids) |> length()
	# IDs from OrthoFinder NOT in GFF. Should be 0.
	of_nonmatches <- length(of_ids) - of_matches
	of_total <- of_matches + of_nonmatches
	# IDs from GFF also in OrthoFinder.
	gff_matches <- which(unique_gff_ids %in% of_ids) |> length()
	# IDs from GFF NOT in OrthoFinder. Could be anything.
	gff_nonmatches <- length(unique_gff_ids) - gff_matches
	# Make some warning noises if necessary.
	if(of_matches/(of_total)*100 < 25){
		stop(paste0('Error. A small fraction of IDs (', of_matches, ' out of ', of_total, ') matches between the OrthoFinder table and the GFF file. Check input options.'))
	} else if(of_nonmatches > 0){
		warning(paste0('Warning: ', of_nonmatches, ' IDs in OrthoFinder table do not match any ID in the GFF file.'))
	}
}

add_og_annotation_to_gff <- function(gff_gr, sp_of_df) {
	gff_gr$OG <- NA
	gff_gr$HOG <- NA
	# Match the ID of the OrthoFinder run to the ID of the GFF file.
	check_match_between_of_gff(sp_of_df$ID, gff_gr)
	m <- match(sp_of_df$ID, gff_gr$ID)
	matching_indices <- m[!is.na(m)]
	# Add OG and HOG to all IDs that are exact-matching
	gff_gr$OG[matching_indices]  <- sp_of_df$OG
	gff_gr$HOG[matching_indices] <- sp_of_df$HOG
	gff_gr
}


# Transfer the OG/HOG annotations to all sibling entries.
transfer_ogs_to_siblings <- function(gff_gr) {
	# Make the "Parent" annotation easier to work with. It's never anything other than a CharacterList of length 0 or 1,
	# but because it is a CharacterList and not a vector, it makes it hard to subset dataframes and whatever. 
	# Make an easier column and use that to do operations, then remove the column later for exporting.
	gff_gr$Parent_easy <- lapply(gff_gr$Parent, \(x) {
		if(length(x) >= 1){
			return(x)
		} else {
			return(NA)
		}
	}) |> unlist()
	# Subset to only entries with annotations
	has_og <- gff_gr[!is.na(gff_gr$OG),]

	# Transfer OG and HOG annotations
	# make a convenient dataframe containing OG annotations from different sources.
	og_df <- data.frame(original_entry=gff_gr$OG)
	# Replace NA OGs and HOGs if either the parent or the ID matches an entry with an OG annotation
	matches_ID <- match(gff_gr$Parent_easy, has_og$ID)
	og_df$parent_vs_ID <- NA
	og_df$parent_vs_ID <- has_og$OG[matches_ID]
	# Another check for when feature is gene
	matches_ID <- match(gff_gr$ID, has_og$Parent_easy)
	og_df$ID_vs_parent <- NA
	og_df$ID_vs_parent <- has_og$OG[matches_ID]
	# Another final check
	matches_ID <- match(gff_gr$Parent_easy, has_og$Parent_easy)
	og_df$parent_vs_parent <- has_og$OG[matches_ID]
	# Add Parent annotation because we might need it for debugging
	og_df$Parent <- gff_gr$Parent_easy
	# Compare from all sources and return NA when all NA or the ID otherwise
	og_df$consensus <- apply(og_df, 1, function(x) {
		if(all(is.na(x[1:4]))){
			return(NA)
		} else {
			unique_ids <- unique(na.omit(x[1:4]))
			if(length(unique_ids) != 1){
				cat('Error: there is some disagreement about orthologue assignment for the following entry. Please check:\n', paste0(x, collapse=', '), file=stderr())
				stop()
			} else {
				return(unique_ids)
			}
		}
	})
	
	gff_gr$OG <- og_df$consensus
	
	# Transfer OG and HOG annotations
	# make a convenient dataframe containing OG annotations from different sources.
	hog_df <- data.frame(original_entry=gff_gr$HOG)
	# Replace NA OGs and HOGs if either the parent or the ID matches an entry with an OG annotation
	matches_ID <- match(gff_gr$Parent_easy, has_og$ID)
	hog_df$parent_vs_ID <- NA
	hog_df$parent_vs_ID <- has_og$HOG[matches_ID]
	# Another check for when feature is gene
	matches_ID <- match(gff_gr$ID, has_og$Parent_easy)
	hog_df$ID_vs_parent <- NA
	hog_df$ID_vs_parent <- has_og$HOG[matches_ID]
	# Another final check
	matches_ID <- match(gff_gr$Parent_easy, has_og$Parent_easy)
	hog_df$parent_vs_parent <- has_og$HOG[matches_ID]
	# Add Parent annotation because we might need it for debugging
	hog_df$Parent <- gff_gr$Parent_easy
	# Compare from all sources and return NA when all NA or the ID otherwise
	hog_df$consensus <- apply(hog_df, 1, function(x) {
		if(all(is.na(x[1:4]))){
			return(NA)
		} else {
			unique_ids <- unique(na.omit(x[1:4]))
			if(length(unique_ids) != 1){
				cat('Error: there is some disagreement about orthologue assignment for the following entry. Please check:\n', paste0(x, collapse=', '), file=stderr())
				stop()
			} else {
				return(unique_ids)
			}
		}
	})
	
	gff_gr$HOG <- hog_df$consensus
	
	# Remove the Parent_Easy column to force it to match original formatting.
	mcols(gff_gr) <- mcols(gff_gr)[,which(colnames(mcols(gff_gr))!="Parent_easy")]
	gff_gr
}


####################################################################
#
# Load input files
#
####################################################################

# string exactly matching a column in the orthofinder output 
species_name <- opt$speciesName
# annotation GFF file
gff <- read_annotation_gff(opt$gff)
# named list of dataframes, each species from the orthofinder table is one element
of <- read_orthofinder(opt$orthoFinder)
sp_of <- of[[species_name]]

message(paste0('Species name:                   ', species_name))
message(paste0('GFF filename:                   ', opt$gff))
message(paste0('GFF gene entries:               ', length(gff[gff$type=='gene']) ))
message(paste0('OrthoFinder column names:       ', paste0(names(of), collapse=', ') ))
message(paste0('Number of genes in orthogroups: ', nrow(sp_of)))


####################################################################
#
# Check input settings 
#
####################################################################
# check that specified species is in orthofinder names, otherwise complain
if(! species_name %in% names(of)) {
	cat(paste0("Error. Specified species name: ", species_name, " is invalid. The following names are valid:\n\t", paste0(names(of), collapse=', '), "\n" ), file=stderr() )
	quit(status=1)
}

# check that other parameters of the data structure look like they are reasonable
if(length(of) == 0) {
	cat(paste0("Error. Somehow failed to parsed orthofinder table. Check formatting.\n"), file=stderr() )
	quit(status=1)
}
if(length(gff) == 0) {
	cat(paste0("Error. GFF file seems to have 0 entries. Does rtracklayer::import() fail with it? Check formatting.\n"), file=stderr() )
	quit(status=1)
}

####################################################################
#
# Do work
#
####################################################################
# Add "OG" and "HOG" annotations to exact-matching IDs in GFF annotation.
gff_with_ogs <- add_og_annotation_to_gff(gff, sp_of)
# Transfer the OG annotations from exact-matching IDs to related entries.
gff_with_ogs_transferred <- transfer_ogs_to_siblings(gff_with_ogs)


####################################################################
#
# Write output files
#
####################################################################
rtracklayer::export(gff_with_ogs_transferred, format='gff3', con=output_basename)


