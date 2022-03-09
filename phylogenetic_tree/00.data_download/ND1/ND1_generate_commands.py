cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python ND1_add.py ' + line

open('commands_ND1_add.txt','w').write(cmd)