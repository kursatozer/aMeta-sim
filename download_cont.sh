
# first download assembly summary
wget -nc https://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/assembly_summary.txt

# get only necessary part
cut -f 1,5,6,8,20 assembly_summary.txt | grep -wv na > only_bacteria.txt

cd -p data/cont

while read BACTERIA
do 
	
	# get only assembly summary ID
	ID=$(grep "${BACTERIA}" only_bacteria.txt | cut -f5 | cut -d "/" -f10)

	# get ftp link
	LINK=$(grep "${BACTERIA}" only_bacteria.txt | cut -f5 | sed 's/https/ftp/g')

	# download ftp
	wget  ${LINK}/${ID}_genomic.fna.gz -O data/cont/${ID}_genomic.fna.gz
	gunzip  data/cont/${ID}_genomic.fna.gz
done < cont.list

Rscript simulate-abundance.R cont
