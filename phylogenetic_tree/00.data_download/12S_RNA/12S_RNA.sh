# conda activate py3
python 12S_RNA_generate_commands.py

ParaFly -c commands_12S_RNA_add.txt -CPU 1
# nohup sh 12S_RNA.sh > 12S_RNA.sh.log 2>&1 &
