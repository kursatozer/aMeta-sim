#!/bin/sh

# to download reference genome
# ./download_reference_genome.sh


# endo

wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/195/955/GCF_000195955.2_ASM19595v2/GCF_000195955.2_ASM19595v2_genomic.fna.gz

# bact
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/765/GCF_000006765.1_ASM676v1/GCF_000006765.1_ASM676v1_genomic.fna.gz

# cont

wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

# endo

gunzip GCF_000222975.1_ASM22297v1_genomic.fna.gz
gunzip GCF_000195955.2_ASM19595v2_genomic.fna.gz

# bact

gunzip GCF_000006765.1_ASM676v1_genomic.fna.gz 

# cont

gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
