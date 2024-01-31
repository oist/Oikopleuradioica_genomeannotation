#!/bin/bash

# this is to convert gtf made by agat to gff3 
# Directory containing the GTF files
gtf_directory="./"

# # Loop through each GTF file in the directory
# for gtf_file in "$gtf_directory"/*.gtf; do
#     if [[ -f "$gtf_file" ]]; then
#         # Create output file path
#         out_file="${gtf_file%.gtf}.gff3"

#         # create a new file
#         cp ${gtf_file} ${out_file}

#         # Replace stuff in place
#         sed -i 's/gtf-version X/custom gff3/g' ${out_file}
#         sed -i 's/id /id=/g' ${out_file}
#         sed -i 's/Parent /Parent=/g' ${out_file}
#         sed -i 's/ID /ID=/g' ${out_file}
#         sed -i 's/tss_type /tss_type=/g' ${out_file}
#         sed -i 's/gene_name /gene_name=/g' ${out_file}
#         sed -i 's/\"//g' ${out_file}
#     fi
# done

find "$gtf_directory" -type f -name "*.gtf" -print0 | while IFS= read -r -d $'\0' gtf_file; do
    if [[ -f "$gtf_file" ]]; then
        # Create output file path
        out_file="${gtf_file%.gtf}.gff3"

        # Create a new file
        cp "$gtf_file" "$out_file"

        # Replace stuff in place
        sed -i 's/gtf-version X/custom gff3/g' "$out_file"
        sed -i 's/id /id=/g' "$out_file"
        sed -i 's/Parent /Parent=/g' "$out_file"
        sed -i 's/ID /ID=/g' "$out_file"
        sed -i 's/tss_type /tss_type=/g' "$out_file"
        sed -i 's/gene_name /gene_name=/g' "$out_file"
        sed -i 's/\"//g' "$out_file"
    fi
done