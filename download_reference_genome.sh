#!/bin/sh

# to download reference genome
# ./download_reference_genome.sh



# bact
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/457/555/GCF_001457555.1_NCTC10562/GCF_001457555.1_NCTC10562_genomic.fna.gz
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/144/405/GCF_000144405.1_ASM14440v1/GCF_000144405.1_ASM14440v1_genomic.fna.gz
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/022/819/245/GCF_022819245.1_ASM2281924v1/GCF_022819245.1_ASM2281924v1_genomic.fna.gz

# cont
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/900/460/135/GCF_900460135.1_41686_D01/GCF_900460135.1_41686_D01_genomic.fna.gz
wget ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/010/605/GCF_000010605.1_ASM1060v1/GCF_000010605.1_ASM1060v1_genomic.fna.gz


# bact
gunzip GCF_001457555.1_NCTC10562_genomic.fna.gz
gunzip GCF_000144405.1_ASM14440v1_genomic.fna.gz
gunzip GCF_022819245.1_ASM2281924v1_genomic.fna.gz

# cont
gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip GCF_900460135.1_41686_D01_genomic.fna.gz
gunzip GCF_000010605.1_ASM1060v1_genomic.fna.gz
