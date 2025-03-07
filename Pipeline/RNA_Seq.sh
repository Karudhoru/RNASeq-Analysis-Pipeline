#!/bin/bash

SECONDS=0

cd /mnt/d/NGS/RNA_Seq

# 0. Create necessary directories

mkdir Data Analysis Alignment Count

# This pipeline:
#  1. Convert SRA files to FASTQ format
#  2. Performs quality control (FastQC)
#  3. Trims adapters and low-quality bases (Trimmomatic)
#  4. Aligns reads to a reference genome (HISAT2)
#  5. Processes BAM files (samtools)
#  6. Counts reads per gene (featureCounts)


# 1. Convert SRA files to FASTQ format
echo "Converting SRA files to FASTQ format"
fastq-dump --skip-technical --read-filter pass SRR11412215 --outdir Data #single-end
fastq-dump --skip-technical --read-filter pass SRR11412216 --outdir Data #single-end 
fastq-dump --skip-technical --read-filter pass SRR11412230 --outdir Data #single-end
fastq-dump --skip-technical --read-filter pass SRR11412229 --outdir Data #single-end

echo "Converted SRA files to FASTQ format"
echo "Moved FASTQ files to Data folder"

rm -rf SRR11412215/ SRR11412230/ SRR11412216/ SRR11412229/
echo "Removed SRA files"

# # 2. Perform quality control

fastqc Data/SRR11412215_pass.fastq Data/SRR11412216_pass.fastq Data/SRR11412229_pass.fastq Data/SRR11412230_pass.fastq -o Analysis
echo "Performed quality control"

# # 3. Trim adapters and low-quality bases

trimmomatic SE -threads 4 -phred33 Data/SRR11412215_pass.fastq Data/controlled_trimmed.fastq LEADING:3 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:36
trimmomatic SE -threads 4 -phred33 Data/SRR11412216_pass.fastq Data/controlled1_trimmed.fastq LEADING:3 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:36
trimmomatic SE -threads 4 -phred33 Data/SRR11412229_pass.fastq Data/infected1_trimmed.fastq LEADING:3 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:36
trimmomatic SE -threads 4 -phred33 Data/SRR11412230_pass.fastq Data/infected_trimmed.fastq LEADING:3 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:36
echo "Trimmed adapters and low-quality bases"

# # 3.2 Perform quality control on trimmed reads

fastqc Data/controlled_trimmed.fastq Data/infected_trimmed.fastq Data/controlled1_trimmed.fastq Data/infected1_trimmed.fastq -o Analysis
echo "Performed quality control on trimmed reads"

# 4. Align reads to reference genome

#run HISAT2
echo "Starting alignment for infected reads"
hisat2 -x Reference_Genome/grch38/genome -U Data/infected_trimmed.fastq -S Alignment/infected.sam
echo "Aligned controlled reads to reference genome"

echo "Starting alignment for infected reads"
hisat2 -x Reference_Genome/grch38/genome -U Data/infected1_trimmed.fastq -S Alignment/infected1.sam
echo "Aligned controlled reads to reference genome"

echo "Starting alignment for infected reads"
hisat2 -x Reference_Genome/grch38/genome -U Data/controlled_trimmed.fastq -S Alignment/controlled.sam
echo "Aligned controlled reads to reference genome"

echo "Starting alignment for controlled reads"
hisat2 -x Reference_Genome/grch38/genome -U Data/controlled1_trimmed.fastq -S Alignment/controlled1.sam
echo "Aligned infected reads to reference genome"

# 5. Process SAM files

# 5.1 Sorting the SAM files
echo "Sorting infected SAM file..."
samtools sort -o Alignment/infected.bam Alignment/infected.sam
echo "Sorting controlled SAM file..."
samtools sort -o Alignment/controlled.bam Alignment/controlled.sam

echo "Sorting infected1 SAM file..."
samtools sort -o Alignment/infected1.bam Alignment/infected1.sam
echo "Sorting controlled1 SAM file..."
samtools sort -o Alignment/controlled1.bam Alignment/controlled1.sam

# Remove the intermediate SAM file
rm Alignment/infected.sam
rm Alignment/controlled.sam
rm Alignment/infected1.sam
rm Alignment/controlled1.sam

# 5.2 Indexing the BAM files
echo "Indexing infected BAM file..."
samtools index Alignment/infected.bam
echo "Indexing controlled BAM file..."
samtools index Alignment/controlled.bam
echo "Indexing infected BAM file..."
samtools index Alignment/infected1.bam
echo "Indexing controlled BAM file..."
samtools index Alignment/controlled1.bam
echo "Processed BAM files"


# 6. Count reads per gene

echo " Started Feature Counts"
featureCounts -T 4 -a Reference_Genome/Homo_sapiens.GRCh38.106.gtf.gz -o Counts/gene_counts.txt Alignment/controlled.bam  Alignment/infected.bam Alignment/infected1.bam Alignment/controlled1.bam
echo "FeatureCounts successfully extracted"

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."





