cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python co1_add.py ' + line

open('commands_co1_add.txt','w').write(cmd)