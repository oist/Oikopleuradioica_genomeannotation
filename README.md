# Oikopleura dioica genome annotation
Genome annotation of *Oikopleura dioica* from different geographical locations: Okinawa, Osaka, and Barcelona.

## About this repository

This repository contains genome annotations of *O. dioica* for the purpose of incremental improvements by hands.

## What is included in this repository

### Core information
3 different fasta genome and GFF3 annotation sets that was used in the scrambling paper (Plessy and Mansfield et al., 2023) https://www.biorxiv.org/content/10.1101/2023.05.09.539028v1. The procedure of the genome annotation is detailed on the Bliznina et al., 2021 paper https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-021-07512-6.

### Liftoff annotations
I have also added Liftoff results from Norwegian *O. dioica* which is located under the resource directory in each genome. They were done using the parameters `-flank 0.5` and `-polish`.

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