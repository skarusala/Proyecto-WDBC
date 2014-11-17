library(shiny)
library(class)

source("helpers.R")

# get data
wdbc <- read.csv("data/wdbc_processed.csv", header=TRUE)

# get rid of IDs
wdbc <- wdbc[-1]

# label vector for knn model
wdbc.labels <- wdbc[, 1]

shinyServer(function(input, output) {
    
    output$o.diagnosis <- renderUI({
        
        # get widget values
        wdbc.test <- c(input$i.radius.1, input$i.texture.1, input$i.perimeter.1,
            input$i.area.1, input$i.smoot.1, input$i.compac.1, input$i.concav.1,
            input$i.cpoints.1, input$i.sym.1, input$i.fdim.1, input$i.radius.2,
            input$i.texture.2, input$i.perimeter.2, input$i.area.2, input$i.smoot.2,
            input$i.compac.2, input$i.concav.2, input$i.cpoints.2, input$i.sym.2,
            input$i.fdim.2, input$i.radius.3, input$i.texture.3, input$i.perimeter.3,
            input$i.area.3, input$i.smoot.3, input$i.compac.3, input$i.concav.3,
            input$i.cpoints.3, input$i.sym.3, input$i.fdim.3)
        
        # create data.frame with train and test sets
        wdbc.plus.test <- rbind(wdbc[,2:31], wdbc.test)
        
        # normalize columns
        wdbc.norm <- as.data.frame(lapply(wdbc.plus.test, normalize))
        
        # split normalized data.frame
        wdbc.train <- wdbc.norm[1:569,]
        wdbc.test <- wdbc.norm[570,]
        
        # use kNN algorithm
        pred <- knn(train=wdbc.train, test=wdbc.test, cl=wdbc.labels, k=7)
        
        # format output
        if (as.numeric(pred) < 2) {
            h1(HTML('<span class="label label-success">Benign</span>'),
               align="center")    
        } else {
            h1(HTML('<span class="label label-danger">Malignant</span>'),
               align="center")
        }
    })
})