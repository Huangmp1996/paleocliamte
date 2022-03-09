d=("12S_RNA" "16S_RNA" "cytb" "co1" "ND1" "ND2")
for str in ${d[@]}
do
    f=`ls $str`
    for file in $f
    do
        sed 's/\r//' $str/$file|awk '/^>/{print s? s"\n"$0:$0;s="";next}{s=s sprintf("%s",$0)}END{if(s)print s}' > ../$str/select_seq/$file
    done
done