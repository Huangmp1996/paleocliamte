import os,re

a = {}
for i in open('fossil_time.txt','r'):
    spl = i.strip().split('\t')
    if a.has_key(spl[0]):
        a[spl[0]].append(spl[1])
    else:
        a[spl[0]] = [spl[1],]
b = {}        
for i in open('fossil_time.txt','r'):
    spl = i.strip().split('\t')
    if len(spl) < 3:continue
    b[spl[0]] = [spl[2],spl[3]]
        
c = ''
for i,j in a.items():
    a1 = 'mrca = '
    a2 = 'min = '
    a3 = 'max = '
    a1 += i + ' '
    for k in j:
        a1 += k + ' '
    a2 += i + ' ' + b[i][0] + ' '
    a3 += i + ' ' + b[i][1] + ' ' 
    c += a1 + '\n' + a2 + '\n' + a3 + '\n'
print c    
