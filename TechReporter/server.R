#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
getSymbols("AAPL")
chartSeries(GOOG, subset = 'last 6 months', theme = chartTheme("white"))
addSMA(n = 200, col = "red")
addSMA(n = 50, col = "blue")
addSMA(n = 20, col = "yellow") 
addSMI()
addRSI()
addMACD()




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
