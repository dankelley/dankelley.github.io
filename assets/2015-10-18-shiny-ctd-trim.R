## ----eval=FALSE----------------------------------------------------------
## library(shiny)
## runApp() # exit by striking ESC on the keyboard

## ----eval=FALSE----------------------------------------------------------
## library(shiny)
## shinyUI(fluidPage(verticalLayout(
##                                  plotOutput("ctdTrimPlot"),
##                                  wellPanel(
##                                            sliderInput("top", "top fraction percent:",
##                                                        min=0, max=100, value=0, step=0.1),
##                                            sliderInput("bottom", "bottom fraction percent:",
##                                                        min=0, max=100, value=100, step=0.1))
##                                  )))

## ----eval=FALSE----------------------------------------------------------
## library(oce)
## file <- file.choose()
## ctdRaw <- read.oce(file)
## ## data(ctdRaw) # try this if you have no .CNV files to test
## shinyServer(function(input, output) {
##             top <- reactive({as.numeric(input$top)})
##             bottom <- reactive({as.numeric(input$bottom)})
##             trimmed <- ctdRaw
##             output$ctdTrimPlot <- renderPlot({
##                 nf <- layout(matrix(c(1, 2, 3, 4, 4, 4), nrow=2, byrow=TRUE))
##                 index <- seq_along(ctdRaw[["pressure"]])
##                 indexStart <- index[1] + 0.01*top() * diff(range(index))
##                 indexEnd <- index[1] + 0.01*bottom() * diff(range(index))
##                 trimmed <- ctdTrim(ctdRaw, method="index", parameters=c(indexStart, indexEnd))
##                 save(trimmed, file="trimmed.rda")
##                 plotProfile(trimmed, xtype="temperature",
##                             mar=c(0.2, 2.2, 2.5, 0.8), mgp=c(1.2, 0.3, 0))
##                 plotProfile(trimmed, xtype="salinity",
##                             mar=c(0.2, 2.2, 2.5, 0.8), mgp=c(1.2, 0.3, 0))
##                 plotTS(trimmed,
##                        mar=c(2.2, 2.2, 1.0, 0.8), mgp=c(1.2, 0.3, 0))
##                 plotScan(ctdRaw,
##                          mar=c(2.5, 2.5, 0.8, 0.8), mgp=c(1.2, 0.3, 0))
##                 suggested <- range(ctdTrim(ctdRaw)[["scan"]])
##                 abline(v=suggested, lty=2, col=c('red', 'blue'))
##                 abline(v=c(indexStart, indexEnd), col=c('red', 'blue'))
##                 legend("topright", c(suggested[1], indexStart,
##                                      suggested[2], indexEnd),
##                        col=c("red", "red", "blue", "blue"),
##                        lty=c(2, 1, 2, 1),
##                        legend=c("Start (suggested)",
##                                 sprintf("Start (user): %.0f", indexStart),
##                                 "End (suggested)",
##                                 sprintf("End (user): %.0f", indexEnd)))
##             }, pointsize=20)
## })

