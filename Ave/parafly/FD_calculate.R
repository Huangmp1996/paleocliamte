grid_id <- commandArgs(TRUE)

library(dplyr)
load('comm_data.RData')
FD_calculate <- function(grid_id,ind_pca,Chinese_species_distribution_grid_selected){
    grid_table <- subset(Chinese_species_distribution_grid_selected,rownames(Chinese_species_distribution_grid_selected)==grid_id)
    grid_table <- subset(grid_table,select=colnames(grid_table)[colSums(grid_table)!=0])
    species <- colnames(grid_table)
    ind_pca_table <- subset(ind_pca,rownames(ind_pca) %in% species)
    FD <- FD::dbFD(ind_pca_table,grid_table,m = 5, calc.FDiv = TRUE)
    if (is.na(FD$FDiv)){
        stop('FDiv error')
    }else{
    result <- data.frame(grid_id,FD$FRic,FD$FEve,FD$FDiv,FD$FDis,FD$RaoQ)
    return(result)
    }
}
FD <- FD_calculate(grid_id,ind_mfa,Chinese_species_distribution_grid_selected)
write.csv(FD,paste0('result/',grid_id,'.csv'),row.names = F)