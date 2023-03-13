# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.

## Gargammel

### Preparing the Environment
Create the necessary environment to use the Gargamel tool smoothly

```
conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel
```

### Requirements:
install necessary tools for simulation analysis

```
conda install -c anaconda cmake
conda install -c anaconda scipy
conda install -c "conda-forge/label/gcc7" biopython
conda install -c "bioconda/label/cf201901" ms
conda install -c "conda-forge/label/gcc7" gsl

```
If you plan on using ms2chromosomes.py to simulate chromosomes based on ms, you also need:

Hudson's ms (see: http://home.uchicago.edu/rhudson1/source/mksamples.html)
seq-gen, you can install on Ubuntu by typing: `conda install -c "bioconda/label/cf201901" seq-gen`

### Overview
The main driver script, gargammel.pl calls the following programs in order to simulate the in vivo process by which ancient DNA fragments are retrieved:

`fragSim`: simulation of ancient DNA fragments being retrieved at random from the genome

`deamSim`: simulation of damage to the fragments selected by fragSim

`adptSim`: adding of adapters to create raw Illumina reads (without errors and quality scores)

`Finally`, the simulated raw Illumina reads are sent to ART to add sequencing errors and corresponding quality scores.

Input description:

The basic input is a directory with 3 subfolders named:

`endo/`

`cont/`

`bact/`

Which represent the endogenous ancient human, the present-day human contaminant and the microbial contamination respectively. Each file inside represents a genome (not simply a chromosome or scaffold). The endogenous ancient human can only contain more than 2 genomes since it is a diploid individual. For the microbial contamination, please add a representative set of microbes for your sample (see the section about the examples of microbial databases).

### Example of usage:
create the necessary files to run the simulation

```
mkdir data
cd data
mkdir endo
mkdir cont
mkdir bact
```

In this section, we will use small pathogen reference genomes to test the program. Let's consider one genome as endogenous reference genome, one as contamination reference genome, and one genome as bacterial reference genome, and export one genome to cont and one to bact file.
```
cd data/endo/
sh ../../download_reference_genome.sh
mv GCF_000005845.2_ASM584v2_genomic.fna ../cont/
mv GCF_000006765.1_ASM676v1_genomic.fna ../bact/
cd ../../
```

or

```
cd data/
python ../ms2chromosomes.py  -s 0.2 -f . -n 1000 
rm -rfv simul_* seedms #cleanup

```

In this method, 1000 simulations of 2 strains allowed to merge after 0.2 units of merging are created. The first will represent our inner ancient human, and the other the present-day human pollutant. It will also produce an additional chromosome from the same population as the contaminant to be used as a reference for alignment.

and set your preferred parameters and run your simulation

```

gargammel -c 3  --comp 0,0.08,0.92 -f src/sizefreq.size.gz  -matfile src/matrices/single-  -o data/simulation data/
```

This will simulate a dataset with 8% human contamination. The rate of misincorporation due to deamination that will be used will follow a single-strand deamination using the empirical rates measured from the Loschbour individual from.
 
