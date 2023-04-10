# Quality control with fastqc
fastqc data/simulation_s1.fq.gz data/simulation_s2.fq.gz 

# Editing data with cutadapt
cutadapt -q 20 -m 30 --trim-n -a AGATCGGAAGAG -A AGATCGGAAGAG -j 4 -o data/simulation_s1_processed.fq.gz -p data/simulation_s2_processed.fq.gz data/simulation_s1.fq.gz data/simulation_s2.fq.gz

# Quality control after cutadapt
fastqc data/simulation_s1_processed.fq.gz data/simulation_s2_processed.fq.gz

# align bidirectional reading with flash for longer readings

mkdir -p results/merged-fastq

flash -m11 -M15 -z data/simulation_s1_processed.fq.gz data/simulation_s2_processed.fq.gz --output-directory results/merged-fastq/ --output-prefix simulation 2>&1 | tee flash.log

zcat results/merged-fastq/simulation.extendedFrags.fastq.gz results/merged-fastq/simulation.notCombined_1.fastq.gz results/merged-fastq/simulation.notCombined_2.fastq.gz | gzip >results/merged-fastq/simulation.merged.fastq.gz  



