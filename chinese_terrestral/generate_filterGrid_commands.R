library(dplyr)
filenames = list.files('./species_distribution_grid')
shapefiles = filenames[grep(".shp$",filenames)]
command <- purrr::map(shapefiles,
             function(x){paste('Rscript grid_filtered.R', x, sep = ' ')}) %>% as.data.frame()
write.table(command,'commands_grid_filter.txt',sep = '\n',row.names = F, col.names = F,quote = F)
