for fasta in `ls 12S_RNA_download/`;
do
    seqkit rename 12S_RNA_download/$fasta;
    refseq=`grep -A1 '|NC_' 12S_RNA_download/$fasta`
    if [ -z @refseq ];then # if species has RefSeq
        seqkit sort --quiet -l -r 12S_RNA_download/$fasta | seqkit head -n 1 > select_seq/$fasta
    else
        echo "$refseq" > select_seq/$fasta
    fi
done

cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10