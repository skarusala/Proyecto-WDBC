wdir <- getwd()

wdbc <- read.csv(file=file.path(wdir, "data", "final", "wdbc_processed.csv"),
                 header=TRUE, stringsAsFactors=FALSE)

# Quitamos la primera columna, que es un identificador y no
# ayudará nada en el modelo (mas bien al contrario).
wdbc <- wdbc[-1]

# Pasamos a factor la variable diagnosis.
wdbc$diagnosis <- factor(wdbc$diagnosis, levels = c("B", "M"))

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

CrossTable(x=wdbc.test.labels, y=wdbc.test.pred,
           prop.chisq=FALSE)

