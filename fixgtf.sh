#!/bin/bash

# Directory containing the GTF files
gtf_directory="./"

# Loop through each GTF file in the directory
for gtf_file in "$gtf_directory"/*.gtf; do
    if [[ -f "$gtf_file" ]]; then
        # Create temporary file path
        temp_file="${gtf_file}.temp"

        # Replace "five_prime_utr" with "five_prime_utr_temp"
        # sed 's/five_prime_utr/five_prime_utr_temp/g' "$gtf_file" > "$temp_file"

        # Run the command using the current GTF file
        # singularity exec /flash/LuscombeU/singularity.cacheDir/gffread_0.12.7--h9a82719_0.sif gffread --force-exons --gene2exon --keep-comments --keep-genes -F -E -T "$gtf_file" > "$temp_file"

        # run AGAT because gffread breaks UTRs
        singularity exec /flash/LuscombeU/singularity.cacheDir/agat_1.2.0--pl5321hdfd78af_0.sif agat_convert_sp_gff2gtf.pl --gff $gtf_file -o $temp_file

        # Replace "five_prime_utr_temp" back to "five_prime_utr"
        # sed 's/five_prime_utr_temp/five_prime_utr/g' "${temp_file}_2" > "$temp_file"

        # Replace the original file with the temporary file
        mv "$temp_file" "$gtf_file"

    fi
done
