library(dplyr)
species_distribution <- readRDS("./input/species_distribution.rds")
spname <- unique(species_distribution$BINOMIAL)
command <- purrr::map(spname,
            function(x){paste('Rscript drawGrid.R', x, sep = ' ')}) %>% as.data.frame()
write.table(command,'commands_drawGrid.txt',sep = '\n',row.names = F, col.names = F,quote = F)
