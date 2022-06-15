china_bird <- read.csv("china_reptile.csv",row.names=1)
grid_id <- row.names(china_bird)
str <- c()
for (i in grid_id) {
	tmp <- paste('Rscript FD_calculate.R',i)
	str <- append(str,tmp)
}
write.table(str,'command.txt',col.names = FALSE,row.names = FALSE,quote = FALSE,sep = '\n')
