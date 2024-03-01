setwd("~/Desktop/R_files/PROJ1/PROJ1")

install.packages("tidyverse")
library(Biostrings)
library(ggplot2)
library(seqinr)
fasta_data <- read.fasta("sequence.fasta", as.string = TRUE)
print(head(fasta_data))
str(fasta_data)
seq <- paste(fasta_data, collapse = "")
seq
dnastring = DNAString(seq)
dnastring
