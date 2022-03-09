cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python cytb_add.py ' + line

open('commands_cytb_add.txt','w').write(cmd)