mafft --maxiterate 1000 --localpair --thread 30 input/cytb_select_seq.fasta  > aln/cytb_mafft.aln
mafft --maxiterate 1000 --localpair --thread 30 input/12S_RNA_select_seq.fasta  > aln/12S_rna_mafft.aln
mafft --maxiterate 1000 --localpair --thread 30 input/ND1_select_seq.fasta  > aln/ND1_mafft.aln
mafft --maxiterate 1000 --localpair --thread 30 input/ND2_select_seq.fasta  > aln/ND2_mafft.aln
# mafft --maxiterate 1000 --localpair --thread 30 input/co1_select_seq.fasta  > aln/co1_mafft.aln
mafft --maxiterate 1000 --localpair --thread 30 input/16S_RNA_select_seq.fasta  > aln/16S_rna_mafft.aln

