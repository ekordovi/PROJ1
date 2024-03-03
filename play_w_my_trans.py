from Bio import SeqIO
from BioSQL import BioSeqDatabase
import sqlite3
import psycopg2


# server = BioSeqDatabase.open_database(driver = "MySQLdb", user = "chapmanb",
#                  passwd = "biopython", host = "localhost", db = "bioseqdb")

conn = sqlite3.connect('PROJ1_BioSQL.sql.db')
cur = conn.cursor()

cur.execute('''CREATE TABLE IF NOT EXISTS Sequences (id TEXT, description TEXT UNIQUE, seq Text)''')
fasta_sequences = SeqIO.parse(open("my_transcripts.fasta"),'fasta')
bling = 0

records = list()
for record in fasta_sequences:
    bling += 1
    cur.execute("INSERT OR IGNORE INTO Sequences (id, description, seq) VALUES (?, ?, ?)", 
                (record.id, record.description, str(record.seq)))
    records.append(record.seq)
    if bling == 1:
        print(record, record.id)
print("Sequences parsed: ", bling)

conn.commit()

conn.close()


