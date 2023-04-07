# Quality control with fastqc
fastqc data/simulation_s1.fq.gz data/simulation_s2.fq.gz 

# Convert zip formatted files to gz format
tar -zcvf simulation_s1_fastqc.gz simulation_s1_fastqc.zip
tar -zcvf simulation_s1_fastqc.gz simulation_s2_fastqc.zip

# Transfer files with cutadapt applied to another folder
mkdir data/cutadapt
mv data/simulation_s1_fastqc.gz data/cutadapt
mv data/simulation_s2_fastqc.gz data/cutadapt
cp data/simulation_s1.fq.gz data/cutadapt
cp data/simulation_s2.fq.gz data/cutadapt

# Editing data with cutadapt
cutadapt -q 28 -m 10 --trim-n -a AGATCGGAAGAG -A AGATCGGAAGAG -j 4 -o data/cutadapt/simulation_s1_fastqc.gz -p data/cutadapt/simulation_s2_fastqc.gz data/cutadapt/simulation_s1.fq.gz data/cutadapt/simulation_s2.fq.gz

# Quality control after cutadapt
fastqc data/cutadapt/simulation_s1_fastqc.gz data/cutadapt/simulation_s2_fastqc.gz



