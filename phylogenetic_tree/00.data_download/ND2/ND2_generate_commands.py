cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python ND2_add.py ' + line

open('commands_ND2_add.txt','w').write(cmd)