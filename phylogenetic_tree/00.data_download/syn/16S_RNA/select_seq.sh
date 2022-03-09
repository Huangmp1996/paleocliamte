mkdir select_seq
for fasta in `ls 16S_RNA_download/`;
do
    seq = grep -A1 'NC_' 16S_RNA_download/$fasta 
    if [! -z $seq];then # if species has RefSeq
        echo $seq > select_seq/$fasta
    else
        seqkit sort --quiet -l -r 16S_RNA_download/$fasta | seqkit head -n 1 > select_seq/$fasta
    fi
done

cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10