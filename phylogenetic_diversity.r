taxon <- commandArgs(TRUE)
phylogenetic_calculate <- function(taxon){
    library(dplyr)
    library(picante)
    library(tidyr)
    phy <- read.tree("./SA_FHZ//RAxML_bestTree.dated.tree")
    Chinese_species_distribution_grid <- read.csv("./chinese_terrestral//species_distribution_grid_filtered.csv",
                                                  header = F, col.names = c("class","species","grid_id","area")) %>% 
                                        group_by(class,species,grid_id) %>% summarise(area = sum(area)) %>% ungroup()
    Chinese_species_distribution_grid_selected <- filter(Chinese_species_distribution_grid,class == taxon) %>% 
                                                    dplyr::select(grid_id,species) %>% as.data.frame() # select taxon distribution
    Chinese_species_distribution_grid_selected$species <- gsub(" ","_",Chinese_species_distribution_grid_selected$species)
    species <- unique(Chinese_species_distribution_grid_selected$species)
    tips <- intersect(phy$tip.label,species) # species has phylogeny data

    Chinese_species_distribution_grid_selected <- filter(Chinese_species_distribution_grid_selected,species %in% tips)
    Chinese_species_distribution_grid_selected$occurrence <- rep(1,nrow(Chinese_species_distribution_grid_selected))
    Chinese_species_distribution_grid_selected <- spread(Chinese_species_distribution_grid_selected,species,occurrence)
    Chinese_species_distribution_grid_selected[is.na(Chinese_species_distribution_grid_selected)] <- 0
    grid_id <- Chinese_species_distribution_grid_selected[,1]
    Chinese_species_distribution_grid_selected <- Chinese_species_distribution_grid_selected[,-1]
    Chinese_species_distribution_grid_selected <- as.matrix(Chinese_species_distribution_grid_selected)
    rownames(Chinese_species_distribution_grid_selected) <- paste0('grid_',grid_id)

    phy_tmp <- keep.tip(phy,tips)
    phy.dist <- cophenetic(phy_tmp)
    nti <- ses.mntd(Chinese_species_distribution_grid_selected,phy.dist,null.model = 'taxa.labels')
    nri <- ses.mpd(Chinese_species_distribution_grid_selected,phy.dist,null.model = 'taxa.labels')
    nti$grid_id <- row.names(nti)
    nri$grid_id <- row.names(nri)
    tmp_result <- full_join(nri,nti,by = 'grid_id')
    return(tmp_result)
}

result <- phylogenetic_calculate(taxon)
write.csv(result,paste0(taxon,'_phylogenetic_diversity.csv'),row.names = F)
