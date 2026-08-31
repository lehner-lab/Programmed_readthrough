# Programmed_readthrough
Programmed translational readthrough produces C-terminally extended protein isoforms via decoding of stop codons by near-cognate tRNAs. Here we use deep mutational scanning to quantify ~5,000 sequence variants for four examples of human readthrough in the genes AQP4, MAPK10, OPRK1 and OPRL1. 

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
After setting up the environment and placing the data in the correct directories, you can run the entire pipeline using the Run_all.R script:
```
Rscript Run_all.R
```

# Running files individually
Files can also be run one at a time, but the order must be preserved and all
commands must run in the **same R session**: each file creates objects reused by
the files after it. The `01`–`07` prefixes indicate the intended order.

From the repository root:
```bash
conda activate Programmed_readthrough
R
```

Then, in that same R session:
```r
dir.create("html_reports", showWarnings = FALSE)
rmarkdown::render("01_Setup.Rmd",           envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("02_Data_processing.Rmd", envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("03_Fig1.Rmd",            envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("04_Fig2.Rmd",            envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("05_Fig3.Rmd",            envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("06_Fig4.Rmd",            envir = globalenv(), output_dir = "html_reports")
rmarkdown::render("07_Fig5.Rmd",            envir = globalenv(), output_dir = "html_reports")
```

`envir = globalenv()` makes each file evaluate in the shared workspace, so its
objects remain available to the next one. Do not quit R in between.

# Exploring the code in RStudio
For interactive exploration we recommend opening the `.Rmd` files in RStudio and
run chunks in order.
Note that RStudio's **Knit** option will not work for files `02`–`07`: it starts
a separate R process, so objects created by earlier files are not visible to it.
