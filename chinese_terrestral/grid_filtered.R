file <- commandArgs(TRUE)
path <- paste('species_distribution_grid/',file,sep = '')

library(sf)
library(dplyr)
inte <- st_read(path)
inte_filtered <- st_set_geometry(inte,NULL) %>% select(c(class,BINOMIAL,id,area))

write.table(inte_filtered,
        paste('species_distribution_grid_filtered/',gsub('.shp','.csv',file),sep=""),
        sep = ',', col.names = FALSE, row.names = FALSE)
