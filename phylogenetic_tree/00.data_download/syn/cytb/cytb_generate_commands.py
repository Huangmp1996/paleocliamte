cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python cytb_add.py ' + line.split('\t')[0] + ' ' + line.split('\t')[1]

open('commands_cytb_add.txt','w').write(cmd)