# Quality control with fastqc
fastqc data/simulation_s1.fq.gz data/simulation_s2.fq.gz 

# Editing data with cutadapt
cutadapt -q 20 -m 30 --trim-n -a -z AGATCGGAAGAG -A AGATCGGAAGAG -j 4 -o data/cutadapt/data/simulation_s1.fq.gz -p data/cutadapt/data/simulation_s2.fq.gz

# Quality control after cutadapt
fastqc data/cutadapt/simulation_s1_fastqc.gz data/cutadapt/simulation_s2_fastqc.gz

# align bidirectional reading with flash for longer readings
flash -m11 -M15 -z  simulation_s1.fq.gz simulation_s2.fq.gz 2>&1 | tee flash.log




