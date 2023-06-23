mkdir -p results/alignment

bowtie2-build --large-index results/sim.assembly/final.contigs.fa results/sim.assembly/final.contigs.fa
bowtie2 --large-index -x results/sim.assembly/final.contigs.fa -U results/merged-fastq/simulation.merged.fastq.gz -S results/alignmentalignment.sam --threads 4
