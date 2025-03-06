# Importing and Using the Conda Environment

This document provides clear instructions on how to import the Conda environment using the provided YAML file and how to activate and use it for your NGS analysis pipeline. This environment includes essential tools such as FastQC, HISAT2, SAMtools, featureCounts.

---

## Prerequisites

- **Conda Installation:**  
  Ensure you have Conda installed on your system (Anaconda or Miniconda is recommended).

- **Environment YAML File:**  
  The YAML file (`environment.yml`) is located in the `environment` folder within your project directory.

---

## Step-by-Step Instructions

### 1. Navigate to Your Project Directory

Open your terminal and change directory to your project folder. For example:
```bash
cd /path/to/your/project
```

### 2. Create the Conda Environment from the YAML File

Run the following command to create the new environment using the YAML file:

```bash
conda env create -f environment/environment.yml
```

### 3. Verify Environment Creation

After the environment is created, list your Conda environments to verify:

```bash
conda env list
```

### 4. Activate the New Environment

Activate the environment by running:

```bash
conda activate <environment_name>
```

### 5. Confirm the Environment is Active

Your terminal prompt should now display the active environment name. You can also run:

```bash
conda info --envs
```

### Additional Tips

## Updating the Environment:

If changes are made to the environment YAML file, update the environment using:

```bash
conda env update -f environment/environment.yml
```

## Deactivating the Environment:

When you are finished, you can deactivate the environment by running:

``` bash
conda deactivate
```

## Documentation for R DESeq2

R DESeq2 is a critical component in this pipeline for differential expression analysis. For more details, refer to the official [DESeq2 Documentation](https://bioconductor.org/packages/release/bioc/html/DESeq2.html).


By following these instructions, you can successfully import and use the Conda environment for your RNA-Seq analysis pipeline, ensuring all necessary tools (including R DESeq2) are available and correctly configured.
