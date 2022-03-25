#coding:utf-8
from Bio import Entrez
from Bio import SeqIO
import os,re

def seq_check(SeqRecord,taxa):
    '''check if SeqReccord belongs to target gene and extract sequence to download_seq'''
    download_seq = ''
    for j in SeqRecord.features:
        if j.type == 'CDS':
            if 'gene' in j.qualifiers.keys():
                if j.qualifiers['gene'][0].upper() in ['NADH DEHYDROGENASE SUBUNIT 1','ND1','MTND1','NADH 1']:
                    if len(j.location) == len(str(SeqRecord.seq)[j.location.start:j.location.end]):
                        m1 = j.location.start
                        n1 = j.location.end
                        if len(str(SeqRecord.seq)[m1:n1]) < 300:continue
                        if int(j.location.strand) > 0:
                            download_seq += '>' + str(taxa) + '|' + 'NCBI' + '|' + SeqRecord.id + '\n' + str(SeqRecord.seq)[m1:n1] + '\n'
                        else:
                           download_seq += '>' + str(taxa) +  '|' + 'NCBI' + '|' + SeqRecord.id + '\n' + str(SeqRecord.seq[m1:n1].reverse_complement()) + '\n'
            elif 'product' in j.qualifiers.keys():
                if j.qualifiers['product'][0] in ['NADH DEHYDROGENASE SUBUNIT 1','ND1','MTND1','NADH 1']:
                    if len(j.location) == len(str(SeqRecord.seq)[j.location.start:j.location.end]):
                        m1 = j.location.start
                        n1 = j.location.end
                        if len(str(SeqRecord.seq)[m1:n1]) < 300:continue
                        if int(j.location.strand) > 0:
                            download_seq += '>' + str(taxa) + '|' + 'NCBI' + '|' + SeqRecord.id + '\n' + str(SeqRecord.seq)[m1:n1] + '\n'
                        else:
                            download_seq += '>' + str(taxa) + '|' + 'NCBI' + '|' + SeqRecord.id + '\n' + str(SeqRecord.seq[m1:n1].reverse_complement()) + '\n'
    return download_seq

def ND1_add(taxa1,taxa2):
    '''download ncbi sequence of species'''
    # Parameter: Mammals_Eulipotyphla_Erinaceidae_Neohylomys_hainanensis
    text = ''
    download_seq = ''
    spl = taxa2.split('_')
    species_name = spl[-2] + ' ' + spl[-1]
    print(species_name)
    Entrez.email = "huangmingpan19@ioz.ac.cn"
    content = '''(ND1[All Fields] OR "NADH dehydrogenase subunit 1"[All Fields] OR "MTND1"[All Fields]) AND ("{}"[Organism]) NOT PREDICTED[title]'''.format(species_name)
    search_result = Entrez.esearch(db="nucleotide",term = content,retmax = 100) # esearch从NCBI检索符合条件的记录，并将结果的summary返回，并没有下载结果
    records = Entrez.read(search_result)
    # print records['Count']
    if 'IdList' in records.keys(): # .read:解析结果 
        ids = records['IdList'] # sequence id in ncbi
        if len(ids) != 0:
            for id in ids: 
                seq_record_hd = Entrez.efetch(db="nucleotide",id=[str(id)],rettype='gb') #efetch命令则执行结果的下载
                seq_info = SeqIO.read(seq_record_hd,'genbank')
                if re.search('UNVERIFIED|from|-like|pseudogene|PREDICTED', seq_info.description): continue
                # if not re.search(species_name.upper(),seq_info.description.upper()):continue
                text += taxa1 + '\t' + str(seq_info.id) + '\t' + str(len(seq_info.seq)) + '\t' + seq_info.description + '\n'
                download_seq += seq_check(seq_info,taxa1)
    out_add_file_name = 'ND1_add/' + taxa1 + '.txt'
    open(out_add_file_name,'w').write(text)
    out_dl_file_name = 'ND1_download/' + taxa1 + '.fasta'
    open(out_dl_file_name,'w').write(download_seq)
    
if __name__ == '__main__':
    ND1_add(os.sys.argv[1],os.sys.argv[2])                     
                    
                    
                    
