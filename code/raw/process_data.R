wdir <- getwd()

wdbc.raw <- read.csv(file=file.path(wdir, "data", "raw", "wdbc_raw.csv"),
                     header=TRUE, stringsAsFactors=FALSE)

mean.names <- c("radius.mean", "texture.mean", "perimeter.mean", "area.mean",
                "smoothness.mean", "compactness.mean", "concavity.mean",
                "concave.points.mean", "symmetry.mean",
                "fractal.dimension.mean")

se.names <- c("radius.se", "texture.se", "perimeter.se", "area.se",
              "smoothness.se", "compactness.se", "concavity.se",
              "concave.points.se", "symmetry.se", "fractal.dimension.se")

worst.names <- c("radius.worst", "texture.worst", "perimeter.worst",
                 "area.worst", "smoothness.worst", "compactness.worst",
                 "concavity.worst", "concave.points.worst", "symmetry.worst",
                 "fractal.dimension.worst")

colnames(wdbc.raw) <- c("id.number", "diagnosis",
                        mean.names, se.names, worst.names)

write.csv(wdbc.raw, 
          file=file.path(wdir, "data", "final", "wdbc_processed.csv"),
          row.names=FALSE)
