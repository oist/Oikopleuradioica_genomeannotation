# README
This directory contains other versions of the annotation 

## bar_complement_liftoff.gff
This file is a gff3 file that contains the original augustus annotation complemented with the liftoff annotation
using a custom script. UTRs have been stripped off using `gff3_file_UTR_trimmer.pl` from pasa pipeline, and the gff file was fixed using AGAT `agat_convert_sp_gxf2gxf.pl`
