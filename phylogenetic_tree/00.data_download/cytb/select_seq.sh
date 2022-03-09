# seqkit rmdup cytb_download/AVES_PASSERIFORMES_LANIIDAE_Lanius_excubitor.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > AVES_PASSERIFORMES_LANIIDAE_Lanius_excubitor.fasta
# mv AVES_PASSERIFORMES_LANIIDAE_Lanius_excubitor.fasta cytb_download/

# seqkit rmdup cytb_download/MAMMALIA_CHIROPTERA_RHINOLOPHIDAE_Rhinolophus_ferrumequinum.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > MAMMALIA_CHIROPTERA_RHINOLOPHIDAE_Rhinolophus_ferrumequinum.fasta
# mv MAMMALIA_CHIROPTERA_RHINOLOPHIDAE_Rhinolophus_ferrumequinum.fasta cytb_download/

for fasta in `ls cytb_download/`;
do
    # fasta=Actinopterygii_Cypriniformes_Danionidae_Danio_rerio.fasta
    refseq=`grep -A1 '|NC_' cytb_download/$fasta`
    if [ $? -eq 0 ];then # if species has RefSeq
        echo "$refseq" |sed 's/-//g' | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo i
    else
        seqkit sort --quiet -l -r cytb_download/$fasta | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo 0
    fi
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10