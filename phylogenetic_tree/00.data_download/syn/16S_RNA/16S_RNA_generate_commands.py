cmd = ''
for line in open('../taxonomy_.csv','r'):
    cmd += 'python 16S_RNA_add.py ' + line.split('\t')[0] + ' ' + line.split('\t')[1]

open('commands_16S_RNA_add.txt','w').write(cmd)