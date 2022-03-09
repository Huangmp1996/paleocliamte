from Bio import Entrez
from Bio import SeqIO
import os,re

def uid(taxa):
    '''get uid in ncbi'''
    # Parameter: Mammals_Eulipotyphla_Erinaceidae_Neohylomys_hainanensis
    spl = taxa.split('_')
    species_name = spl[-2] + ' ' + spl[-1]
    print(species_name)
    Entrez.email = "huangmingpan19@ioz.ac.cn"
    content = '''"{}"[Organism]'''.format(species_name)
    search_result = Entrez.esearch(db="taxonomy",term = content,retmax = 100) # esearch从NCBI检索符合条件的记录，并将结果的summary返回，并没有下载结果
    records = Entrez.read(search_result)
    # print records['Count']
    if 'IdList' in records.keys(): # .read:解析结果 
        ids = records['IdList'] # sequence id in ncbi
        if len(ids) == 0:
            return(taxa)

text = ''
for line in open('../taxonomy_.csv','r'):
    line = line.strip()
    taxa = uid(line)
    if taxa is not None:
        text += taxa + '\n'

open('taxa_not_in_ncbi','w').write(text)
