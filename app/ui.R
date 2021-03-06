library(shiny)

shinyUI(fluidPage(theme="bootstrap.css",
                  
    titlePanel(title="WDBC: A tool for breast cancer diagnosis",
               windowTitle="WDBC: A tool for cancer diagnosis"),
    
    fluidRow(
        column(2,               
               h4("Introduction:"),
               p("Welcome to WDBC, a revolutionary tool for breast cancer diagnosis that
                 uses state of the art machine learning algorithms to help you.")),
        column(2,
               h4("Radius"),
               sliderInput("i.radius.1",
                           label="Mean:",
                           min=6.5, max=28.5, value=14.5, step=2),
               sliderInput("i.radius.2",
                           label="SE:",
                           min=0.1, max=3.1, value=0.5, step=0.2),
               sliderInput("i.radius.3",
                           label="Worst:",
                           min=7.5, max=36.5, value=17.5, step=2),
               br()
        ),
        column(2,
               h4("Texture"),
               sliderInput("i.texture.1",
                           label="Mean:",
                           min=9.5, max=39.5, value=19.5, step=2),
               sliderInput("i.texture.2",
                           label="SE:",
                           min=0.3, max=4.9, value=0.5, step=0.2),
               sliderInput("i.texture.3",
                           label="Worst:",
                           min=12, max=50, value=26, step=2)                       
        ),
        column(2, 
               h4("Perimeter"),
               sliderInput("i.perimeter.1",
                           label="Mean:",
                           min=43, max=193, value=93, step=10),
               sliderInput("i.perimeter.2",
                           label="SE:",
                           min=0.7, max=22.7, value=2.7, step=2),
               sliderInput("i.perimeter.3",
                           label="Worst:",
                           min=50, max=250, value=110, step=10)       
        ),
        column(2,
               h4("Area"),
               sliderInput("i.area.1",
                           label="Mean:",
                           min=100, max=2500, value=700, step=100),
               sliderInput("i.area.2",
                           label="SE:",
                           min=0, max=550, value=40, step=25),
               sliderInput("i.area.3",
                           label="Worst:",
                           min=100, max=4300, value=900, step=200)   
        ),
        column(2,
               h4("Smoothness"),
               sliderInput("i.smoot.1",
                           label="Mean:",
                           min=0.05, max=0.17, value=0.09, step=0.01),
               sliderInput("i.smoot.2",
                           label="SE:",
                           min=0.001, max=0.031, value=0.007, step=0.002),
               sliderInput("i.smoot.3",
                           label="Worst:",
                           min=0.07, max=0.22, value=0.13, step=0.01)   
        )
    ),
    fluidRow(
        column(2,
               h4("Instructions:"),
               p("Take the results for the medical screening on a 
                 breast mass and set the associate values for the
                 different sliders."),
               p("The default values are placed at the mean for the
                 variable of interest.")),
        column(2,
               h4("Compactness"),
               sliderInput("i.compac.1",
                           label="Mean:",
                           min=0.01, max=0.35, value=0.11, step=0.02),
               sliderInput("i.compac.2",
                           label="SE:",
                           min=0, max=0.13, value=0.02, step=0.01),
               sliderInput("i.compac.3",
                           label="Worst:",
                           min=0, max=1, value=0.25, step=0.05)
        ),
        column(2,
               h4("Concavity"),
               sliderInput("i.concav.1",
                           label="Mean:",
                           min=0, max=0.40, value=0.08, step=0.02),
               sliderInput("i.concav.2",
                           label="SE:",
                           min=0, max=0.40, value=0.02, step=0.02),
               sliderInput("i.concav.3",
                           label="Worst:",
                           min=0, max=1.2, value=0.3, step=0.05)                       
        ),
        column(2, 
               h4("Concave points"),
               sliderInput("i.cpoints.1",
                           label="Mean:",
                           min=0, max=0.2, value=0.04, step=0.01),
               sliderInput("i.cpoints.2",
                           label="SE:",
                           min=0, max=0.05, value=0.01, step=0.005),
               sliderInput("i.cpoints.3",
                           label="Worst:",
                           min=0, max=0.3, value=0.1, step=0.03)       
        ),
        column(2,
               h4("Symmetry"),
               sliderInput("i.sym.1",
                           label="Mean:",
                           min=0.1, max=0.3, value=0.18, step=0.01),
               sliderInput("i.sym.2",
                           label="SE:",
                           min=0.005, max=0.08, value=0.02, step=0.005),
               sliderInput("i.sym.3",
                           label="Worst:",
                           min=0.15, max=0.70, value=0.30, step=0.03)   
        ),
        column(2,
               h4("Fractal dimension"),
               sliderInput("i.fdim.1",
                           label="Mean:",
                           min=0.05, max=0.1, value=0.06, step=0.002),
               sliderInput("i.fdim.2",
                           label="SE:",
                           min=0, max=0.02, value=0.004, step=0.001),
               sliderInput("i.fdim.3",
                           label="Worst:",
                           min=0.05, max=0.25, value=0.08, step=0.01)               
        )
    ),
    fluidRow(
        column(2),
        column(4,
               h3("Diagnosis:"),
               uiOutput("o.diagnosis")               
        ),
        column(6)
    )
))
