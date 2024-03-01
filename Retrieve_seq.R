# Install necessary packages 
install.packages("rentrez") # For accesing NCBI
install.packages("ape")      # For phylogenetic tree manipulation and visualization
install.packages("seqinr")   # For sequence manipulation
# Bioconductor package - DECIPHER
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DECIPHER")
BiocManager::install("Biostrings")
# Load necessary libraries
library(rentrez)
library(ape)
library(seqinr)
library(Biostrings)
library(DECIPHER)
# 1. Retrieve Sequences
query <- "Phaeobacter piscinae"
search_results <- entrez_search(db = "nucleotide", term = query, retmax = 100)  # Adjust retmax as needed
ids <- search_results$ids
sequences <- entrez_fetch(db = "nucleotide", id = ids, rettype = "fasta")

sequences_list <- scan(text = sequences, what = character(), sep = ">")

# Remove any empty strings
sequences_list <- sequences_list[sequences_list != ""]

# Read the sequences into R
dna <- readDNAStringSet(sequences_list)


BiocManager::valid()
R.version
# 2. Sequence Alignment (optional)
AlignSeqs(dna)
# 3. Phylogenetic Inference
# Once you have aligned sequences, you can use phylogenetic inference methods
# For example, you can use the 'phangorn' package for maximum likelihood phylogenetic inference
# Or 'ape' package for neighbor-joining or UPGMA methods

# Example with ape package:
aligned_sequences <- read.alignment("aligned_sequences.fasta", format = "fasta")
phy_tree <- nj(dist.dna(aligned_sequences))
plot(phy_tree, main = "Phylogenetic Tree of Phaeobacter piscinae")

# 4. Tree Visualization
# You can visualize the phylogenetic tree using plotting functions from the 'ape' package
# Customize the plot as needed to make it interpretable and publication-ready
