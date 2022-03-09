# compare files in add and download, to find out sequence not write in download
cd ND2_add
find ./ -name "*" -type f -size 0c > ../empty_add.txt
cd ../ND2_download
find ./ -name "*" -type f -size 0c > ../empty_dl.txt
# find ./ -name "*" -type f -size 0c |sed 's/\.\//python ND2_add.py /g' |sed 's/\.fasta//g' >> ../FailedCommands

cd ..
# sort commands_ND2_add.txt FailedCommands FailedCommands | uniq -u > commands_ND2_add.txt.completed
sed -i 's/fasta/txt/g' ./empty_dl.txt
sort empty_dl.txt empty_add.txt empty_add.txt | uniq -u > diff_add_minus_dl.txt