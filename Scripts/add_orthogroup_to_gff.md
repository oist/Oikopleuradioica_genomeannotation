# add_orthogroup_to_gff.R
## Purpose
To add OrthoFinder OG and HOG annotations to a species' gene annotation in GFF format, suitable for viewing in IGV or other browsers.

## Description
An R script that uses the TSV output of OrthoFinder (`NX.tsv`, where X is the name of the node on the underlying species tree) and 

## Prerequisites
Requires a new-ish version of R (4.1.0 or later) because it uses pipes.

Also requires the libraries `optparse`, `S4Vectors`, `GenomicRanges`, and `rtracklayer`.

## Usage

```
Usage: Rscript add_orthogroup_to_gff.R [options]                                                                                                                                               
                                                                                                                                                                                       
                                                                                                                                                                                       
Options:                                                                                                                                                                               
        -n SPECIESNAME, --speciesName=SPECIESNAME                                                                                                                                      
                String reporting species name. Must exactly match a column in the OrthoFinder output. Default: none                                                                    
                                                                                                                                                                                       
        -f ORTHOFINDER, --orthoFinder=ORTHOFINDER                                                                                                                                      
                OrthoFinder TSV output file containing HOG and OG annotations. Default: none                                                                                           
                                                                                                                                                                                       
        -g GFF, --gff=GFF                                                                                                                                                              
                Annotation GFF file to add orthogroup annotations to. Default: none                                                                                                                                                                                                                                                                                           
        -o OUTPUT, --output=OUTPUT                                                                                                                                                     
                Base name to use for output files (i.e., a gff3-formatted annotation file with orthogroup annotations added). Default: [genomeName]_orthofinder.gff                    
                                                                                                                                                                                       
        -h, --help                                                                                                                                                                     
                Show this help message and exit        
```

