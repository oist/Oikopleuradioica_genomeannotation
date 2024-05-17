# Oikopleura dioica genome annotation
Genome annotation of *Oikopleura dioica* from different geographical locations: Okinawa, Osaka, and Barcelona. Genome browser is currently hosted on [oikobrowser.jnicolaus.com](http://oikobrowser.jnicolaus.com)

## About this repository

This repository contains genome annotations of *O. dioica* for the purpose of incremental improvements by hands.

## What is included in this repository

### Core information
3 different fasta genome and GTF annotation sets that was used in the scrambling paper (Plessy and Mansfield et al., 2023) https://www.biorxiv.org/content/10.1101/2023.05.09.539028v1. The procedure of the genome annotation is detailed on the Bliznina et al., 2021 paper https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-021-07512-6.

These are:
- `OKI.I69/v2/OKI.I69.v2.0.gtf` Okinawa
- `Bar2_p4/v1/Bar2_p4.Flye.v1.0.gtf` Barcelona
- `OSKA2016v1.9/v2/OSKA2016v1.9.v2.0.gtf` Osaka

### Other version of annotations
1. I have created other versions which incorporate CAGE data from https://github.com/oist/LuscombeU-CAGE_libraries/ to add 5' UTRs as follows:
- `./OKI.I69/v2.1/OKI2018_I69_5primeutr_v2.1.gtf` v2.0 + 5' UTR
- `./Bar2_p4/v1.1/Bar2_p4_5primeutr_v1.1.gtf` v1.0 + 5' UTR
- `./Bar2_p4/v4/Bar2_p4_5primeutr_v4.0.gtf` v1.0 + 5' UTR complemented with liftoff results from Norway (http://oikoarrays.biology.uiowa.edu/Oiko/)
  - This modifies the original annotation by adding gene models that do not overlap **in the same strand** with v1.0
- `./OSKA2016v1.9/v2.1/OSKA2016_5primeutr_v2.1.gtf` v2.0 + 5' UTR

2. Version X.2 is the version with 5' UTR with the addition of `gene_name` attribute obtained from eggnog using the longest transcript assigned to respective `gene_id` using the following parameters:
`-m diamond ---evalue 0.001 --score 60 --pident 40 --query_cover 20 --subject_cover 20 --itype proteins --tax_scope auto --target_orthologs all --go_evidence non-electronic --pfam_realign none --report_orthologs`

3. Version X.3 is the version with 5' UTR (CAGE) and 3' UTR (Canonical polyA site), supplemented with valid liftoff gene models, and genes split according to CAGE peaks and liftoff gene models using the package `github.com/oist/LuscombeU_annotationpolish`. GTF was created using AGAT, gff3 files were sanitised using AGAT.


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


More info on gff3 and gtf file formats:
https://www.ensembl.org/info/website/upload/gff3.html
https://asia.ensembl.org/info/website/upload/gff.html?redirectsrc=//www.ensembl.org%2Finfo%2Fwebsite%2Fupload%2Fgff.html

## Contact information
Johannes Nicolaus Wibisana of The Luscombe Unit of the Okinawa Institute of Science and Technology is maintaining this repository. For questions please email johannes.nicolaus@oist.jp.
