# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.

## gargammel

```
conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel
```
### Downloading:
Do a :
```
git clone https://github.com/grenaud/gargammel.git
```

### Requirements:
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

fragSim: simulation of ancient DNA fragments being retrieved at random from the genome
deamSim: simulation of damage to the fragments selected by fragSim
adptSim: adding of adapters to create raw Illumina reads (without errors and quality scores)
Finally, the simulated raw Illumina reads are sent to ART to add sequencing errors and corresponding quality scores.

```
python ../ms2chromosomes.py  -s 0.2 -f . -n 1000
rm -rfv simul_* seedms #cleanup
```

```
gargammel -c 3  --comp 0,0.08,0.92 -f src/sizefreq.size.gz  -matfile src/matrices/single-  -o data/simulation data/
```






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

