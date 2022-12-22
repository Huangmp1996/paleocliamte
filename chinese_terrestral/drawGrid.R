args <- commandArgs(TRUE) 
species = paste(args[1],args[2],sep=" ")
print(species)
# print(paste('species_distribution/',args[1],".shp",sep=""))

library(dplyr)
library(sf)
equal_area_grid <- st_read("./input/grid.shp")
species_distribution <- readRDS("./input/species_distribution.rds")
mysp <- subset(species_distribution,
              BINOMIAL %in% species &
              ORIGIN %in% c(1, 2, 5, 6) &
              PRESENCE %in% c(1, 2, 4, 5) &
              SEASONAL %in% c(1, 2)
              )
rm(species_distribution)

mysp <- st_transform(mysp,crs = st_crs(equal_area_grid)) %>% st_buffer(dist=0)
st_intersection(mysp, equal_area_grid) %>% mutate(area=st_area(geometry)) -> inte
st_write(inte,paste('species_distribution_grid/',gsub(" ","_",species),".shp",sep=""),append=FALSE) # if want to write out 'inte'

