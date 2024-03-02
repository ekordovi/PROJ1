from Bio import SeqIO

fasta_sequences = SeqIO.parse(open("my_transcripts.fasta"),'fasta')
bling = 0
for record in fasta_sequences:
    bling += 1
    print(record.id)
    if bling == 1:
        print(record, record.id)


records = list(fasta_sequences)