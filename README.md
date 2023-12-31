# Oikopleura dioica genome annotation
Genome annotation of *Oikopleura dioica* from different geographical locations: Okinawa, Osaka, and Barcelona. Genome browser is currently hosted on [oikobrowse.jnicolaus.com](http://oikobrowser.jnicolaus.com)

## About this repository

This repository contains genome annotations of *O. dioica* for the purpose of incremental improvements by hands.

## What is included in this repository

### Core information
3 different fasta genome and GFF3 annotation sets that was used in the scrambling paper (Plessy and Mansfield et al., 2023) https://www.biorxiv.org/content/10.1101/2023.05.09.539028v1. The procedure of the genome annotation is detailed on the Bliznina et al., 2021 paper https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-021-07512-6.

These are:
- `OKI.I69/v2/OKI.I69.v2.0.gff3` Okinawa
- `Bar2_p4/v1/Bar2_p4.Flye.v1.0.gff3` Barcelona
- `OSKA2016v1.9/v2/OSKA2016v1.9.v2.0.gff3` Osaka

### Other version of annotations
I have created other versions which incorporate CAGE data from https://github.com/oist/LuscombeU-CAGE_libraries/ to add 5' UTRs as follows:
- `./OKI.I69/v2.1/OKI2018_I69_5primeutr_v2.1.gff3` v2.0 + 5' UTR
- `./Bar2_p4/v1.1/Bar2_p4_5primeutr_v1.1.gff3` v1.0 + 5' UTR
- `./Bar2_p4/v4/Bar2_p4_5primeutr_v4.0.gff3` v1.0 + 5' UTR complemented with liftoff results from Norway (http://oikoarrays.biology.uiowa.edu/Oiko/)
  - This modifies the original annotation by adding gene models that do not overlap **in the same strand** with v1.0
- `./OSKA2016v1.9/v2.1/OSKA2016_5primeutr_v2.1.gff3` v2.0 + 5' UTR


### Liftoff annotations
I have also added Liftoff results from Norwegian *O. dioica* which is located under the resource directory in each genome. They were done using the parameters `-flank 0.5` and `-polish`.

### Index files
Index files are required for fasta files and were created using `samtools faidx`.

### Conservation tracks
Conservation tracks under `/resources/conservation_tracks` were computed using `cactus`, `cactus-hal2maf` and `halPhyloP` using default settings for 4 different species including Osaka, Barcelona, Norway and Okinawa.

### Synteny track
Synteny was calculated across species using LAST.

## How to use this repository

### To add manual annotation
1. Clone the repository and create a new branch for your changes.
2. To add a new gene that was not annotated before, add a new gene annotation to the GFF3 file.
3. To fix a gene model that was previously annotated wrongly, remove the old gene annotation and add the new gene model.

To add new genes, please add an identifier so that we know that the gene was edited manually. 


More info on gff3 file format:
https://www.ensembl.org/info/website/upload/gff3.html

## Contact information
Johannes Nicolaus Wibisana of The Luscombe Unit of the Okinawa Institute of Science and Technology is maintaining this repository. For questions please email johannes.nicolaus@oist.jp.
