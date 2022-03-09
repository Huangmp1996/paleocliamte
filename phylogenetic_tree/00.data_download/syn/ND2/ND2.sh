# conda activate py3
python ND2_generate_commands.py

ParaFly -c commands_ND2_add.txt -CPU 1
# nohup sh ND2.sh > ND2.sh.log 2>&1 &
