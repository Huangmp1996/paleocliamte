library(FD)

ind_mfa <- read.csv("ind_mfa.csv",row.names=1)
china_bird <- read.csv("china_reptile.csv",row.names=1)

i <- commandArgs(TRUE) 
grid_table <- subset(china_bird,rownames(china_bird)==i)
grid_table <- subset(grid_table,select=colnames(grid_table)[colSums(grid_table)!=0])
species <- colnames(grid_table)
rownames(ind_mfa) <- gsub(" ",".",rownames(ind_mfa))
mfa_table <- subset(ind_mfa,rownames(ind_mfa) %in% species)

tmp <- dbFD(mfa_table,grid_table)
tmp <- data.frame(i,tmp$FRic,tmp$FEve,tmp$FDiv,tmp$FDis,tmp$RaoQ)
write.csv(tmp,paste("result/",i,".csv",sep=''),row.names=F)
