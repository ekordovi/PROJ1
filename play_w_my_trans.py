import re
from Bio import SeqIO
import sqlite3


# server = BioSeqDatabase.open_database(driver = "MySQLdb", user = "chapmanb",
#                  passwd = "biopython", host = "localhost", db = "bioseqdb")

conn = sqlite3.connect('PROJ1_BioSQL.sql.db')
cur = conn.cursor()

cur.execute('''CREATE TABLE IF NOT EXISTS Sequences (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, Seqid TEXT, description TEXT UNIQUE, seq Text)''')
fasta_sequences = SeqIO.parse(open("my_transcripts.fasta"),'fasta')
bling = 0

records = []
for record in fasta_sequences:
    bling += 1
    cur.execute("INSERT OR IGNORE INTO Sequences (Seqid, description, seq) VALUES (?, ?, ?)", 
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

# defining motif pattern
motif_pattern = re.compile(r"AT[A|T]G")

# motif search
motif_positions_dict = {}
motif_positions_dict = {}
try:
    for record, seq in zip(records, all_seqs):
        seq_id = record.id
        matches = motif_pattern.finditer(seq)
        motif_positions = [match.start() for match in matches]
        motif_positions_dict[seq_id] = motif_positions
except Exception as e:
    print("An error occurred while processing motif positions:", e)

# printing motif positions for each seq. 
#for seq_id, motif_positions in motif_positions_dict.items():
#    print(f"Motif matches in sequence {seq_id}: {motif_positions}")

conn.commit()
conn.close()
