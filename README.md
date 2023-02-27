# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.

```
export PATH=/home/kursat/anaconda3/bin:$PATH
```

```
conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel
```

```
conda install r-inline r-gam r-Rcpp r-RcppGLS r-RcppGSL r-ggplot2
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

