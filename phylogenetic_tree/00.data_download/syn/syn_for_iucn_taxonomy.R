library(dplyr)
total <- read.csv("../taxonomy_.csv",header=F,col.names=c('taxa'))

total <- tidyr::separate(total,taxa,into = c("class","order","family","genus","species"),sep = "_",remove = F) %>% na.omit()
total$binomial <- paste(total$genus,total$species,sep = ' ')
total <- dplyr::select(total,taxa,binomial)

source('get_IUCN_synonyms.R')

syn_result <- get_IUCN_synonyms(total$binomial)
result <- left_join(total,syn_result,by = c('binomial'='result.accepted_name'))
result$result.synonym <- gsub(' ','_',result$result.synonym)

write.table(result,"syn_result_for_empty_dl.txt",row.names = F,sep = '\t',quote = F)

# create taxonomy_ file to run
result <- read.table("syn_result_for_empty_dl.txt",sep = '\t',header=T,quote = "")
taxa_not_in_ncbi <- read.table('taxa_not_in_ncbi',sep='\t',header=F,col.names=c('taxa'))
taxa_not_in_ncbi_add_iucn_syn <- left_join(taxa_not_in_ncbi,result,by = 'taxa') %>% select(taxa,result.synonym) %>% distinct()
taxa_not_in_ncbi_add_iucn_syn <- tidyr::separate(taxa_not_in_ncbi_add_iucn_syn,taxa,
                                                    into = c("class","order","family","genus","species"),sep = "_",remove = F)
taxonomy <- c()
for (i in 1:nrow(taxa_not_in_ncbi_add_iucn_syn)){
    if (!is.na(taxa_not_in_ncbi_add_iucn_syn$result.synonym[i])) {
        str <- paste(taxa_not_in_ncbi_add_iucn_syn$class[i],taxa_not_in_ncbi_add_iucn_syn$order[i],
                taxa_not_in_ncbi_add_iucn_syn$family[i],taxa_not_in_ncbi_add_iucn_syn$result.synonym[i],sep = '_')
    }else{
        str = taxa_not_in_ncbi_add_iucn_syn$taxa[i]
    }
    taxonomy <- append(taxonomy,str)
}
taxonomy <- data.frame(taxa_not_in_ncbi_add_iucn_syn$taxa,taxonomy)
write.table(taxonomy,'taxonomy_.csv',sep='\t',row.names = F,quote=F,col.names=F)
# write.table(taxa_not_in_ncbi_add_iucn_syn,'taxa_not_in_ncbi_add_iucn_syn.txt',sep = '\t',row.names=F)