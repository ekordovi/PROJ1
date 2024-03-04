from Bio import SeqIO
import sqlite3


# server = BioSeqDatabase.open_database(driver = "MySQLdb", user = "chapmanb",
#                  passwd = "biopython", host = "localhost", db = "bioseqdb")

conn = sqlite3.connect('PROJ1_BioSQL.sql.db')
cur = conn.cursor()

cur.execute('''CREATE TABLE IF NOT EXISTS Sequences (id TEXT, description TEXT UNIQUE, seq Text)''')
fasta_sequences = SeqIO.parse(open("my_transcripts.fasta"),'fasta')
bling = 0

records = []
for record in fasta_sequences:
    bling += 1
    cur.execute("INSERT OR IGNORE INTO Sequences (id, description, seq) VALUES (?, ?, ?)", 
                (record.id, record.description, str(record.seq)))
    records.append(record)
    if bling == 1:
        print(record, record.id)
print("Sequences parsed: ", len(records))

table_seq = cur.execute("SELECT (seq) FROM Sequences")
all_seqs = [record[0] for record in cur.fetchall()]




seq_lengths = [len(seq) for seq in all_seqs]

print("Summary stats of sequence lengths: ")
print("min length:", min(seq_lengths))
print("Maximum length:", max(seq_lengths))
print("Mean length:", sum(seq_lengths) / len(seq_lengths))


conn.commit()
conn.close()