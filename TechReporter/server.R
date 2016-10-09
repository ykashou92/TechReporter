#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(quantmod)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Make a chart for a symbol, with the settings from the inputs
  stock.sym <- reactive ({
    tryCatch({
      suppressWarnings(getSymbols(input$stock, auto.assign = FALSE))
    }, error = function(err) {
      return(NULL)
      })
  })

  output$mainPlot <- renderPlot({
    if(!is.null(stock.sym())) {
    chartSeries(stock.sym(),
                name = input$stock,
                subset = 'last 6 months', 
                theme = chartTheme("white", 
                                   up.col = "#87CEEB", 
                                   dn.col = "red", 
                                   fg.col = "black", 
                                   bg.col = "white"))
    }
  })
})
  
