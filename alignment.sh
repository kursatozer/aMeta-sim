mkdir -p data/mapped
mkdir -p data/index

bowtie2-build results/sim.assembly/final.contigs.fa data/index/contigs
bowtie2 -x data/index/contigs -U results/merged-fastq/simulation.merged.fastq.gz -S data/mapped/alignment.sam --threads 4
