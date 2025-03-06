library(DESeq2)
library(ggplot2)
library(ggrepel)

counts_raw <- read.delim("D:/NGS/RNA_Seq/Counts/gene_counts.txt", comment.char="#", header=TRUE)
count_matrix <- counts_raw[,7:ncol(counts_raw)]
rownames(count_matrix) <- counts_raw$Geneid

# Create a sample metadata data frame
sample_info <- data.frame(
  condition = factor(c("control", "infected", "infected", "control")),
  row.names = colnames(count_matrix)
)

# Create a DESeq2 dataset and run the differential expression analysis
dds <- DESeqDataSetFromMatrix(countData = count_matrix, colData = sample_info, design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)

# Save or inspect results
write.csv(as.data.frame(res), file="DE_results.csv")
head(res)


# Generate a volcano plot

# Compute -log10(p-value)
res$logPadj <- -log10(res$padj + 1e-10)

# Create a significance column
res$significance <- "Not Significant"
res$significance[which(res$pvalue < 0.05 & abs(res$log2FoldChange) >= 1)] <- "Significant"

volcano <- ggplot(as.data.frame(res), aes(x = log2FoldChange, y = logPadj, color = significance)) +
  geom_point(alpha = 0.8, size = 2) +
  # Add threshold lines for fold change and significance
  geom_vline(xintercept = c(-1, 1), linetype = "dotted", color = "black") +
  geom_hline(yintercept = -log10(0.05), linetype = "dotted", color = "black") +
  theme_minimal() +
  scale_color_manual(values = c("Significant" = "orange", "Not Significant" = "cyan")) +
  xlab("log2 Fold Change") +
  ylab("-log10(P-adj)") +
  ggtitle("Volcano Plot of Differential Expression") +
  theme(plot.title = element_text(hjust = 0.5),
        legend.title = element_blank())


top_genes <- head(as.data.frame(res[order(res$logP), ]), 10)
 volcano <- volcano +
   geom_text_repel(data = top_genes,
                    aes(label = rownames(top_genes)),
                    size = 3,
                    box.padding = 0.3,
                    point.padding = 0.2)

 # MA plot (mean expression vs. log fold change)
 plotMA(dds, ylim = c(-5, 5))
 

 # Transform counts for visualization
 vsd <- vst(dds, blind = FALSE)

 # Plot PCA
 plotPCA(vsd, intgroup = "condition")
 
 
 
 