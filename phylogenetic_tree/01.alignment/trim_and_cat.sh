for aln in `ls aln/`
do 
    seqkit replace -w 0 -p "\|.+" aln/$aln > trimmed/$aln
    trimal -in trimmed/$aln -out trimmed/${aln}_trimmed
done

./catfasta2phyml-master/catfasta2phyml.pl --concatenate --sequential trimmed/*_trimmed  1> six_gene.phy 2>six_gene.phy.log