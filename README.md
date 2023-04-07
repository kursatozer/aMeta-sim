# aMeta-sim
In this study, it is aimed to make analyzes using ancient metagenome simulations.

## Gargammel

### Preparing the Environment
Create the necessary environment to use the Gargamel tool smoothly

```
conda env
conda create --name gargammel
conda activate gargammel
conda install -c bioconda gargammel
```

### Requirements:
install necessary tools for simulation analysis

```
conda install -c anaconda cmake
conda install -c anaconda scipy
conda install -c "conda-forge/label/gcc7" biopython
conda install -c "bioconda/label/cf201901" ms
conda install -c "conda-forge/label/gcc7" gsl

```
If you plan on using ms2chromosomes.py to simulate chromosomes based on ms, you also need:

Hudson's ms (see: http://home.uchicago.edu/rhudson1/source/mksamples.html)
seq-gen, you can install on Ubuntu by typing: `conda install -c "bioconda/label/cf201901" seq-gen`

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
```

Firstly 1000 simulations of 2 strains allowed to merge after 0.2 units of merging are created. The first will represent our inner ancient human, and the other the present-day human pollutant. It will also produce an additional chromosome from the same population as the contaminant to be used as a reference for alignment.

```

python ../ms2chromosomes.py  -s 0.2 -f . -n 1000 
rm -rfv simul_* seedms
cd ..
```

Next, let's download the environmental bacterial contamination in the `cont.list file` in addition to the human contamination in the contamination folder. Let's download bacteria from the oral flora in the `bacteria.list` file to be simulated as ancient in the `Bact` folder.

```
sh download_bact.sh
sh download_cont.sh
```

 ### Bacterial databases
Create a file named 'list' in the bact folder and specify the frequency of the bacteria; for example

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
gargammel -n 210000  --comp 0.67,0.03,0.3 -f src/sizefreq.size.gz  -rl 125 --loc 3.6978229805 --scale 0.2699858954 -damageb 0.04,0.3,0.02,0.3 -o data/simulation data
```
## Analysis
Create and activate a new environment to avoid package version conflicts

```
conda env
conda create --name analysis
conda activate analysis
```
