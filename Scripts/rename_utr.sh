#!/bin/bash

# Define the directory to search in as one level up from the current directory
DIRECTORY="../"

# Use find to recursively search for files with specific extensions, then use sed to replace the patterns
find "$DIRECTORY" \( -name "*.gff3" -o -name "*.gff" -o -name "*.gtf" \) -type f -exec sed -i 's/five_prime_utr/five_prime_UTR/g' {} +
find "$DIRECTORY" \( -name "*.gff3" -o -name "*.gff" -o -name "*.gtf" \) -type f -exec sed -i 's/three_prime_utr/three_prime_UTR/g' {} +

echo "Replacement complete."
