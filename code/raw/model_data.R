wdir <- getwd()

wdbc <- read.csv(file=file.path(wdir, "data", "final", "wdbc_processed.csv"),
                 header=TRUE, stringsAsFactors=FALSE)

# Quitamos la primera columna, que es un identificador y no
# ayudará nada en el modelo (mas bien al contrario).
wdbc <- wdbc[-1]

# Pasamos a factor la variable diagnosis.
wdbc$diagnosis <- factor(wdbc$diagnosis, levels = c("B", "M"))

# Intento de aleatorización por filas
# Ojo cuando se hace... antes me daba fallo porque aleatorizaba sin
# etiquetas...
set.seed(314)
wdbc <- wdbc[sample(nrow(wdbc)),]

# Tipificamos el data frame (razón vista en el analisis exploratorio).
wdbc.norm <- as.data.frame(scale(wdbc[-1]))

# Separamos conjunto de entrenamiento y de test (100 para este último).
wdbc.train <- wdbc.norm[1:469, ]
wdbc.test <- wdbc.norm[470:569, ]

# Etiquetas para el modelo
wdbc.train.labels <- wdbc[1:469, 1]
wdbc.test.labels <- wdbc[470:569, 1]

if(!require("class")) {
    install.packages("class")
    library(class)
}

wdbc.test.pred <- knn(train=wdbc.train, test=wdbc.test,
                      cl=wdbc.train.labels, k=21)

if(!require("gmodels")) {
    install.packages("gmodels")
    library(gmodels)
}

ct <- CrossTable(x=wdbc.test.labels, y=wdbc.test.pred,
                 prop.chisq=FALSE)

#false.negative <- ct$prop.tabl[2,1]
#false.positive <- ct$prop.tabl[1,2]

false.negative.vec <- vector()
false.positive.vec <- vector()

for (i in seq(1,50)) {
    wdbc.test.pred <- knn(train=wdbc.train, test=wdbc.test,
                          cl=wdbc.train.labels, k=2*i-1)
    ct <- CrossTable(x=wdbc.test.labels, y=wdbc.test.pred,
                     prop.chisq=FALSE)
    false.negative.vec[i] <- ct$prop.tbl[2,1]    
    false.positive.vec[i] <- ct$prop.tbl[1,2]    
}

k.dataframe <- data.frame(k=2*seq(1,50)-1,
                          fp=false.positive.vec,
                          fn=false.negative.vec)

if (!require(reshape2)) {
    install.packages("reshape2")
    library(reshape2)
}
dat.m <- melt(k.dataframe, id.vars = "k")

if (!require(ggplot2)) {
    install.packages("ggplot2")
    library(ggplot2)
}

ggplot(dat.m, aes(x = k, y = value, fill=variable)) +
    geom_bar(stat='identity')

# Tremenda cantidad de falsos negativos... el mejor valor para k sería 3.

#
# Cambio de estrategia, en lugar de tipificar, normalizamos:
#
normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x)))
}

wdbc.norm2 <- as.data.frame(lapply(wdbc[2:31], normalize))

# Y repetimos el análisis de nuevo:
wdbc.train2 <- wdbc.norm2[1:469, ]
wdbc.test2 <- wdbc.norm2[470:569, ]

wdbc.train.labels <- wdbc[1:469, 1]
wdbc.test.labels <- wdbc[470:569, 1]

false.negative.vec2 <- vector()
false.positive.vec2 <- vector()

for (i in seq(1,50)) {
    wdbc.test.pred <- knn(train=wdbc.train2, test=wdbc.test2,
                          cl=wdbc.train.labels, k=2*i-1)
    ct <- CrossTable(x=wdbc.test.labels, y=wdbc.test.pred,
                     prop.chisq=FALSE)
    false.negative.vec2[i] <- ct$prop.tbl[2,1]    
    false.positive.vec2[i] <- ct$prop.tbl[1,2]    
}

k.dataframe2 <- data.frame(k=2*seq(1,50)-1,
                           fp=false.positive.vec2,
                           fn=false.negative.vec2)

dat.m2 <- melt(k.dataframe2, id.vars = "k")

ggplot(dat.m2, aes(x = k, y = value, fill=variable)) +
    geom_bar(stat='identity')
# Funciona mejor con esta normalización
# Un buen para k sería k=7.


