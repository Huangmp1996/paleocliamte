cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python 12S_RNA_add.py ' + line

open('commands_12S_RNA_add.txt','w').write(cmd)