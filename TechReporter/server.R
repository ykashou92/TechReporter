################
### server.R ###
################

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
    TA.indicators = "addVo(); addBBands(); addMACD(); addRSI(); 
addSMI(n = 3, fas = 3, slow = 14); addSMA(n = 200, col = 'yellow');
addSMA(n = 50, col = 'green')"
    
    if(!is.null(stock.sym())) {
    chartSeries(stock.sym(),
                name = input$stock,
                subset = 'last 6 months', 
                TA = TA.indicators,
                theme = chartTheme("white", 
                                   up.col = "#87CEEB", 
                                   dn.col = "red", 
                                   fg.col = "black", 
                                   bg.col = "white"))
    }
  })
})
  
