# seqkit rmdup 16S_RNA_download/MAMMALIA_CARNIVORA_FELIDAE_Lynx_lynx.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > MAMMALIA_CARNIVORA_FELIDAE_Lynx_lynx.fasta
# mv MAMMALIA_CARNIVORA_FELIDAE_Lynx_lynx.fasta 16S_RNA_download/


for fasta in `ls 16S_RNA_download/`;
do
    #remove duplicated seqs and get rid of '\n' of result
    refseq=`grep -A1 '|NC_' 16S_RNA_download/$fasta`
    if [ $? -eq 0 ];then # if species has RefSeq
        echo "$refseq" |sed 's/-//g' | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo i
    else
        seqkit sort --quiet -l -r 16S_RNA_download/$fasta | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo 0
    fi
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10