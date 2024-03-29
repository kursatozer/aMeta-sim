# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.

## Gargammel

### Preparing the Environment
Set up the necessary environment for smooth usage of the Gargammel tool:

```
conda install -c bioconda cutadapt
conda install -c anaconda python
conda env create -f environment.yml
conda activate aMetasim
```

### Overview
The main driver script, gargammel.pl calls the following programs in order to simulate the in vivo process by which ancient DNA fragments are retrieved:

`fragSim`: simulation of ancient DNA fragments being retrieved at random from the genome

`deamSim`: simulation of damage to the fragments selected by fragSim

`adptSim`: adding of adapters to create raw Illumina reads (without errors and quality scores)

`Finally`, the simulated raw Illumina reads are sent to ART to add sequencing errors and corresponding quality scores.

Input description:

The basic input is a directory with 3 subfolders named:

`endo/`

`cont/`

`bact/`

Which represent the endogenous ancient human, the present-day human contaminant and the microbial contamination respectively. Each file inside represents a genome (not simply a chromosome or scaffold). The endogenous ancient human can only contain more than 2 genomes since it is a diploid individual. For the microbial contamination, please add a representative set of microbes for your sample (see the section about the examples of microbial databases).

### Example of usage:
create the necessary files to run the simulation

```
mkdir data
cd data
mkdir endo
mkdir cont
mkdir bact
cd ..
```
### Downloading Data

To begin, download two Homo sapiens chromosome files of the same type and place them in the 'endo' folder. Alternatively, you can add the previously downloaded chromosome file to the 'endo' folder again, giving it a different name. The first of these chromosomes will be simulated to represent ancient humans, while the second will be simulated to represent modern human populations. (You can use a single chromosome file from this link: https://www.ncbi.nlm.nih.gov/nuccore/NC_000001.11?report=gbwithparts&log$=seqview) Alternatively, you can simulate both ancient and modern chromosomes using the tool provided in the code.

Next, let's download the environmental bacterial contamination in the `cont.list file` in addition to the human contamination in the contamination folder. Let's download bacteria from the oral flora in the `bacteria.list` file to be simulated as ancient in the `Bact` folder.

```
cd data/
python ../ms2chromosomes.py  -s 0.2 -f . -n 1000 
rm -rfv simul_* seedms #cleanup
cd ../
sh download_bact.sh
sh download_cont.sh
```

 ### Bacterial databases
Specify the frequency of bacteria to manually create a file named 'list' in the Bact folder; For example

```
GCF_000144405.1_ASM14440v1_genomic.fna      0.4
GCF_001457555.1_NCTC10562_genomic.fna       0.3
GCF_022819245.1_ASM2281924v1_genomic.fna    0.3
```

### Options
`-comp [B,C,E]` Composition of the final set in fraction 
the 3 numbers represent the bacterial, contaminant and endogenous
ex: `--comp 0.6,0.02,0.38` will result
in 60% bacterial contamination while the rest will be from the same
species 5% will be contamination and 95% will be endogenous
Default: --comp 0,0,1
and set your preferred parameters and run your simulation

`-f`: a file to specify read length distribution
`--mock`: Do nothing, just print the commands that will be run
`-o`: Output prefix (default: [input dir]/simadna)
 Either specify:
`-n [number]`: Generate [number] fragments (default: 1000)
`-c	[coverage]`: Endogenous coverage 

 #### Fragment selection
	Fragment size distribution: specify either one of the 3 possible options:
`-l	[length]`: Generate fragments of fixed length  (default: 35)
`-s	[file]`: Open file with size distribution (one fragment length per line)
`-f	[file]`: Open file with size frequency in the following format:
length[TAB]freq	ex:

```
40	0.0525
41	0.0491
 ```

#### Length options:
`--loc [file]`: Location for lognormal distribution (default none)
`--scale [file]`: Scale for lognormal distribution    (default none)

#### Fragment size limit:
`--minsize [length]`: Minimum fragments length (default: 0)
`--maxsize	[length]`: Maximum fragments length (default: 1000)

#### Deamination
`-damage` [v,l,d,s]: For the Briggs et al. 2007 model
The parameters must be comma-separated e.g.: `-damage 0.03,0.4,0.01,0.3`

`-damageb` [v,l,d,s]: Bacterial Briggs parameters
v: nick frequency
l: length of overhanging ends (geometric parameter)
d: prob. of deamination of Cs in double-stranded parts
s: prob. of deamination of Cs in single-stranded parts

#### Adapter and sequencing
`-rl`	[length]			Desired read length  (Default: 75)

### Run Gargammel
After completing all the necessary preparations, specify the options and parameters suitable for your work after the `gargammel` command and run it.

```
gargammel -n 1000000 --comp 0.45,0.45,0.1 -f src/sizefreq.size.gz -damage 0.03,0.4,0.01,0.3 -o data/simulation data
```
## Analysis

### Start Analysis of Ancient Metagenomic Simulation
"sim_analysis.sh" involves a series of steps for processing metagenomic simulation data. Firstly, the quality of data is assessed using `fastqc` to ensure its integrity. Subsequently, data is processed and trimmed using `cutadapt`. The quality of processed data is re-evaluated using `fastqc`. The `flash` tool is utilized to merge long reads, and ultimately, the merged data is compressed. These steps encompass the simulation analysis, encompassing data quality assurance, processing, and merging.

```
sh sim_analysis.sh
```

### Assembly With Megahit
Assembly With Megahit: Following the preprocessing steps, the merged and compressed data generated earlier is subjected to genome assembly using the `megahit` tool. This assembly process is executed with multiple k-mer lengths (21 to 101) using the -k-list parameter to improve the coverage of assembly across different read lengths. The tool utilizes four threads (-t 4) to parallelize the assembly process. The resulting assembled contigs are saved in the 'results/sim.assembly' directory, contributing to the comprehensive analysis of the metagenomic simulation data.
```
megahit -f -r results/merged-fastq/simulation.merged.fastq.gz -t 4 --k-list 21,31,41,51,61,71,81,91,101 -o results/sim.assembly
```

### Taxonomic Classification
The download_database.sh script encompasses the steps necessary for acquiring and preparing the database required for the usage of the Kraken2 taxonomic classification tool. These steps involve downloading, extracting, and placing the required database into the specified directory. Subsequently, the kraken2 command performs the taxonomic classification by utilizing both the merged contigs and the downloaded database. This process aids in determining the organisms to which the contigs belong. The classification outcomes are saved in the k2_report.txt report file, while the outputs containing taxonomic labels are written into the kraken_output.txt file. These steps collectively conclude the taxonomic analysis of metagenomic simulation data."

```
sh download_database.sh 
kraken2 --db results/k2_standard_08gb_20230314 results/sim.assembly/final.contigs.fa --report results/k2_report.txt --output results/kraken_output.txt
```
