# conda activate py3
python cytb_generate_commands.py

ParaFly -c commands_cytb_add.txt -CPU 1
# nohup sh cytb.sh > cytb.sh.log 2>&1 &
