# aMeta-sim

In this study, it is aimed to make analyzes using ancient metagenome simulations.

## Gargammel

### Preparing the Environment

We have two different ways to install Gargammel. First, we can just install the base gargammel, and then we can install to tools that gargammel need:

```bash
conda create --name gargammel -c bioconda gargammel
conda activate gargammel
```

Do a :

```bash
git clone https://github.com/grenaud/gargammel.git
```

Then install the dependencies

```bash
conda install -c anaconda cmake
conda install -c anaconda scipy
conda install -c "conda-forge/label/gcc7" biopython
conda install -c "bioconda/label/cf201901" ms
conda install -c "conda-forge/label/gcc7" gsl
```

Second way, we can install all these tools using the predefined gargammel conda environment:

```bash
conda env create -f environment.yml
```

If you plan on using ms2chromosomes.py to simulate chromosomes based on ms, you also need:

Hudson's ms (see: http://home.uchicago.edu/rhudson1/source/mksamples.html)

seq-gen, you can install on Ubuntu by typing: `conda install -c "bioconda/label/cf201901" seq-gen`

### Overview

The main driver script, `gargammel.pl` calls the following programs in order to simulate the in vivo process by which ancient DNA fragments are retrieved:

`fragSim`: simulation of ancient DNA fragments being retrieved at random from the genome

`deamSim`: simulation of damage to the fragments selected by fragSim

`adptSim`: adding of adapters to create raw Illumina reads (without errors and quality scores)

Finally, the simulated raw Illumina reads are sent to ART to add sequencing errors and corresponding quality scores.

Input description:

The basic input is a directory with 3 subfolders named:

+ `endo/`
+ `cont/`
+ `bact/`

Which represent the endogenous ancient human, the present-day human contaminant and the microbial contamination respectively. Each file inside represents a genome (not simply a chromosome or scaffold). The endogenous ancient human can only contain more than 2 genomes since it is a diploid individual. For the microbial contamination, please add a representative set of microbes for your sample (see the section about the examples of microbial databases).

### Example of usage:

First let's clone the gargammel repository:

```bash
git clone https://github.com/grenaud/gargammel.git
cd gargammel
```

This is an example of usage to simulate a slightly contaminated (8%) dataset. First, we will simulate chromosomes using ms and seq-gen:

```bash
mkdir data
```

First create two subfolders:

```bash
cd data
mkdir cont
mkdir endo
mkdir bact
```

We always need these three directories to run it.

In these folders, we need to copy reference fasta files. As an example, we created three arbitrary reference genomes like this:

`cont/cont-01.fna`
`cont/cont-02.fna`
`endo/endo-01.fna`

Then, we need to run the script like this:

```bash
cd..
gargammel -c 3  --comp 0,0.08,0.92 -f src/sizefreq.size.gz  -matfile src/matrices/single-  -o data/simulation data/
```

Let's give more information on options:

+ `--comp`: The compositon of the simulated DNA: bact,cont,endo 
+ `-matfile`: The substition matrix
+  `-f`: a file to specify read length distribution


## internship-project
```
conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel
```

```
conda install -c "conda-forge/label/gcc7" r-inline
conda install -c "conda-forge/label/gcc7" r-gam
conda install -c "conda-forge/label/gcc7" r-rcpp
conda install -c "conda-forge/label/cf202003" r-rcppgsl
conda install -c "conda-forge/label/gcc7" r-ggplot2
conda install -c "bioconda/label/cf201901" bwa
conda install -c "bioconda/label/cf201901" mapdamage2
```

```
conda activate gargammel
cd data/
sh download_reference_genome.sh
cd ..
```

```
samtools faidx data/GCF_000005845.2_ASM584v2_genomic.fna
```

```
fragSim -n 100000 -l 100 data/GCF_000005845.2_ASM584v2_genomic.fna  > data/modern.fasta
```

```
deamSim -mapdamage ~/gargammel/examplesMapDamage/results_LaBrana/misincorporation.txt double data/modern.fasta > data/ancient.fasta
```

```
bwa index data/GCF_000005845.2_ASM584v2_genomic.fna
bwa mem data/GCF_000005845.2_ASM584v2_genomic.fna data/ancient.fasta | samtools view -Sb > data/ancient.bam


samtools sort data/ancient.bam > data/ancient.sorted.bam


samtools index data/ancient.sorted.bam

mapDamage -i data/ancient.sorted.bam -r data/GCF_000005845.2_ASM584v2_genomic.fna
```

