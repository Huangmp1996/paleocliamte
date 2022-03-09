# conda activate py3
python 16S_RNA_generate_commands.py

ParaFly -c commands_16S_RNA_add.txt -CPU 1
# nohup sh 16S_RNA.sh > 16S_RNA.sh.log 2>&1 &
