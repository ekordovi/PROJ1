install.packages("RSQLite")
library(RSQLite)
library(Biostrings)

# connect to db
conn <- dbConnect(RSQLite::SQLite(), dbname = "PROJ1_BioSQL.sql.db")

results <- dbGetQuery(conn, "SELECT seq FROM Sequences")

# translating each DNA seq
protein_seqs <- list()
for (i in 1:nrow(results)) {
  dna_seq <- results[i, "seq"]
  # translate DNA sequence
  protein_seq <- translate(DNAString(dna_seq))
  protein_seqs[[i]] <- as.character(protein_seq)
}

print(protein_seqs[95])


dbDisconnect(conn)