for fasta in `ls ND1_download/`;
do
    refseq=`grep -A1 '|NC_' ND1_download/$fasta`
    if [ $? -eq 0 ];then # if species has RefSeq
        echo "$refseq" |sed 's/-//g' | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo i
    else
        seqkit sort --quiet -l -r ND1_download/$fasta | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo 0
    fi
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10