# seqkit rmdup co1_download/MAMMALIA_RODENTIA_SCIURIDAE_Callosciurus_pygerythrus.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > MAMMALIA_RODENTIA_SCIURIDAE_Callosciurus_pygerythrus.fasta
# mv MAMMALIA_RODENTIA_SCIURIDAE_Callosciurus_pygerythrus.fasta co1_download/


for fasta in `ls co1_download/`;
do
    # fasta=Actinopterygii_Cypriniformes_Danionidae_Danio_rerio.fasta
    refseq=`grep -A1 '|NC_' co1_download/$fasta`
    if [ $? -eq 0 ];then # if species has RefSeq
        echo "$refseq" |sed 's/-//g' | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo i
    else
        seqkit sort --quiet -l -r co1_download/$fasta | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo 0
    fi
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10