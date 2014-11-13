wdir <- getwd()

wdbc <- read.csv(file=file.path(wdir, "data", "final", "wdbc_processed.csv"),
                 header=TRUE, stringsAsFactors=FALSE)

str(wdbc)

if (!require("pastecs")) {
    install.packages("pastecs")
    library(pastecs)
}

# Cambio para evitar notación científica y muchos decimales
options(scipen=100)
options(digits=2)

stat.desc(wdbc)
# Hay grandes diferencias de escala entre variables.
# Ojo de cara a su influencia en la función de distancia
# para el algoritmo kNN.

table(wdbc$diagnosis)
# Tal y como afirman en las notas. De momento todo bien.