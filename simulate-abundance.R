args = commandArgs(trailingOnly=TRUE)
source <- args[1]

files <- dir(paste0("data/", source))

abundance <- rep(1/length(files), length(files))
abundances <- data.frame(cbind(files, abundance))
write.table(x=abundances, file = paste0("data/", source,"/list"), row.names=FALSE, col.names=FALSE, quote=FALSE, sep = "\t")
