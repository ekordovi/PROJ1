setwd("~/Desktop/R_files/PROJ1/PROJ1")

install.packages("tidyverse")
library(Biostrings)
library(ggplot2)

download.file('ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Escherichia_coli/reference/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz',
              'genome.fna.gz')

genome <- readDNAStringSet("genome.fna.gz")

print(genome)

letters
# generating from "ACTG" 
sample(LETTERS[c(1,3,7,20)], size=10, replace=TRUE)
# doing that w/ biostrings
DNA_ALPHABET
seq = sample(DNA_ALPHABET[1:4], size=10, replace=TRUE)
seq = paste(seq, collapse="")
seq
bstring = BString("I am a BString object")
length(bstring)
# making DNAstring object
dnastring = DNAString("TTGAAA-CTC-N")
dnastring
alphabetFrequency(dnastring)
alphabetFrequency(dnastring, baseOnly=TRUE, as.prob=TRUE)

# reverse complement 
reverseComplement(dnastring)
# indexing with subseq()
subseq(dnastring, 7, 12)
