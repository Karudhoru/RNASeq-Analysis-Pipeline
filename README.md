# RNA-Seq Analysis Pipeline

A comprehensive, modular pipeline for RNA sequencing (RNA-Seq) analysis. This pipeline streamlines the process from raw sequencing reads to differential gene expression analysis, making it easier to integrate into your bioinformatics workflows.

## Overview

The RNA-Seq Analysis Pipeline automates the key steps in gene expression analysis, including:

- **Data Acquisition:** Downloading RNA-Seq data from the Sequence Read Archive (SRA), along with reference genome and annotation (GTF) files.
- **Pre-processing:** Converting SRA files to FASTQ format, assessing read quality using FastQC and MultiQC, and trimming adapters/low-quality bases with Trimmomatic.
- **Read Alignment:** Mapping reads to a reference genome using HISAT2.
- **Post-alignment Processing:** Sorting and indexing BAM files using Samtools.
- **Quantification:** Counting reads per gene using featureCounts.
- **Differential Expression Analysis:** Identifying differentially expressed genes using DESeq2 in R, along with visualizations such as volcano plots, MA plots, PCA plots, and heatmaps.

This pipeline is designed with modularity and reproducibility in mind, allowing you to easily customize and extend its functionality.

## Features

- **Modular Design:** Easily swap out tools or add new ones based on your requirements.
- **Automation:** End-to-end processing from raw RNA-Seq reads to gene expression results.
- **Scalability:** Suitable for both small experiments and large-scale transcriptomic studies.
- **Reproducibility:** Configuration files and version control ensure that analyses can be replicated.

## Requirements

- **Operating System:** Linux-based systems (tested on Ubuntu)
- **Programming Language:** Bash, R (for differential expression analysis)
- **Tools:**
  - [Git](https://git-scm.com/)
  - [SRA Toolkit](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)
  - [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
  - [MultiQC](https://multiqc.info/)
  - [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
  - [HISAT2](https://daehwankimlab.github.io/hisat2/)
  - [Samtools](http://www.htslib.org/)
  - [featureCounts](http://bioinf.wehi.edu.au/featureCounts/)
  - [R](https://www.r-project.org/) with [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html)

## Repository Structure 

```plaintext
├── Data
│   ├── ReadME.pdf
│   └── data.sh
├── Docs
│   └── ToolsandSteps.pdf
├── Environment
│   ├── ReadME.pdf
│   └── environment.yml
├── Pipeline
│   └── RNA_Seq.sh
├── QC Analysis
│   ├── SRR11412215_pass_fastqc.pdf
│   ├── SRR11412216_pass_fastqc.pdf
│   ├── SRR11412229_pass_fastqc.pdf
│   ├── SRR11412230_pass_fastqc.pdf
│   ├── controlled_trimmed_fastqc.pdf
│   ├── infected1_trimmed_fastqc.pdf
│   └── infected_trimmed_fastqc.pdf
├── README.md
├── Results
│   ├── DE_results.csv
│   ├── MA_Plot.png
│   ├── PCA.png
│   └── volcano_plot.png
└── bin
    └── DE_Analysis.R


## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/RNASeq-Analysis-Pipeline.git
   cd RNASeq-Analysis-Pipeline
   ```

2. **Install Required Dependencies:**
   Ensure all required tools and R packages are installed before running the pipeline.

## Usage

To execute the pipeline, follow the step-by-step guide provided in the documentation.


