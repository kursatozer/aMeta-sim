# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.


export PATH=/home/kursat/anaconda3/bin:$PATH

conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel

conda install r-inline r-gam r-Rcpp r-RcppGLS r-RcppGSL r-ggplot2

conda activate gargammel
cd data/
sh download_reference_genome.sh
cd ..