# conda activate py3
python generate_commands.py

ParaFly -c commands_co1_add.txt -CPU 1
# nohup sh co1.sh > co1.sh.log 2>&1 &
