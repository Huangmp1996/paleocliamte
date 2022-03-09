for fasta in `ls ND2_download/`;
do
    seqkit sort --quiet -l -r ND2_download/$fasta | seqkit head -n 1 > select_seq/$fasta;
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10