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
sequences <- entrez_fetch(db = "nuccore", id = ids, rettype = "fasta")
cat(strwrap(substr(sequences, 1, 500)), sep="\n")

write(sequences, file="my_transcripts.fasta")

sequences_list <- scan(text = sequences, what = character(), sep = ">")
sequence_set <- readDNAStringSet(sequences, format = "fasta")
print(head(sequence_set))
# Remove any empty strings
sequences_list <- sequences_list[sequences_list != ""]
print(head(sequences_list))
length(sequences_list)
class(sequences_list)

split_sequences <- strsplit(sequences_list, " ")
head(split_sequences)
vclass(split_sequences)
# split_sequences is a list of characters
# i want to turn these characters into Bstrings
# Initialize an empty list to store BString objects
list_Bstrings <- list()

# Convert each character vector to a BString and append to the list
for (i in split_sequences) {
  if (length(i) == 1 && !is.na(i)) {
    list_Bstrings <- c(list_Bstrings, BString(i))
  } else {
    # Handle cases where i is not a single character vector
    # Print a message or take appropriate action
    print(paste("Skipping invalid sequence:", i))
  }
}


dna_set <- DNAStringSet(split_sequences)

# 2. Sequence Alignment (optional)
AlignSeqs(split_sequences[1], split_sequences[2])
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
