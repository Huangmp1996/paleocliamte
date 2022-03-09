# seqkit rmdup 12S_RNA_download/MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_pileatus.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_pileatus.fasta
# mv MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_pileatus.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_shortridgei.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' >  MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_shortridgei.fasta
# mv MAMMALIA_PRIMATES_CERCOPITHECIDAE_Trachypithecus_shortridgei.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_chinensis.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_chinensis.fasta
# mv REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_chinensis.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_elegans.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_elegans.fasta
# mv REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_elegans.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_leucostictus.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_leucostictus.fasta
# mv REPTILIA_SQUAMATA_SCINCIDAE_Plestiodon_leucostictus.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/REPTILIA_SQUAMATA_VARANIDAE_Varanus_salvator.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > REPTILIA_SQUAMATA_VARANIDAE_Varanus_salvator.fasta
# mv REPTILIA_SQUAMATA_VARANIDAE_Varanus_salvator.fasta 12S_RNA_download/

# seqkit rmdup 12S_RNA_download/REPTILIA_SQUAMATA_VARANIDAE_Varanus_bengalensis.fasta | perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' > REPTILIA_SQUAMATA_VARANIDAE_Varanus_bengalensis.fasta
# mv REPTILIA_SQUAMATA_VARANIDAE_Varanus_bengalensis.fasta 12S_RNA_download/

for fasta in `ls 12S_RNA_download/`;
do
    refseq=`grep -A1 '|NC_' 12S_RNA_download/$fasta`
    if [ $? -eq 0 ];then # if species has RefSeq
        echo "$refseq" |sed 's/-//g' | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo i
    else
        seqkit sort --quiet -l -r 12S_RNA_download/$fasta | seqkit head -n 1 -w 0 > select_seq/$fasta
        # echo 0
    fi
done
cat select_seq/* | seqkit fx2tab -n -l |sort -r -n -t$'\t' -k2|head -n 10