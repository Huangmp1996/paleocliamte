# conda activate py3
python ND1_generate_commands.py

ParaFly -c commands_ND1_add.txt -CPU 1
# nohup sh ND1.sh > ND1.sh.log 2>&1 &
