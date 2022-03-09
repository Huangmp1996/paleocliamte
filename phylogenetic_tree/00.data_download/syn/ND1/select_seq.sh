for fasta in `ls ND1_download/`;
do
    seqkit sort --quiet -l -r ND1_download/$fasta | seqkit head -n 1 > select_seq/$fasta;
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10