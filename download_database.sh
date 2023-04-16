# download database
wget https://genome-idx.s3.amazonaws.com/kraken/standard_08gb_20230314/inspect.txt
wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20230314.tar.gz

# database extraction
gunzip k2_standard_20230314.tar.gz
mkdir -p results/k2_standard_08gb_20230314
tar -xvf k2_standard_08gb_20230314.tar -C ~/aMeta-sim/results/k2_standard_08gb_20230314

