# Programmed_readthrough
Programmed translational readthrough produces C-terminally extended protein isoforms via decoding of stop codons by near-cognate tRNAs. Here we use deep mutational scanning to quantify ~1,400 sequence variants for each of the three examples of human readthrough in the genes AQP4, MAPK10 and OPRK1. 

# Project Workflow and Execution
This project consists of a sequential pipeline. To ensure reproducibility and simplify execution, you can run the entire workflow with a single command.

# Prerequisites
1. Clone the repository:

```
git clone https://github.com/lehner-lab/Programmed_readthrough.git
cd Programmed_readthrough
```

2. Create and activate the Conda environment:

```
conda env create -f environment.yml
conda activate Programmed_readthrough
```

# How to Run the Pipeline
After setting up the environment and placing the data in the correct directories, you can run the entire pipeline using the main Python script:

```
python main.py
```
