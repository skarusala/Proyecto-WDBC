url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"

wdbc.internet <- read.csv(url, header=FALSE, stringsAsFactors=FALSE)

wdir <- getwd()

write.csv(wdbc.internet, 
          file=file.path(wdir, "data", "raw", "wdbc_raw.csv"),
          row.names=FALSE)
