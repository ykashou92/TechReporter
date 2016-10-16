################
### server.R ###
################

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste(Sys.time())
  })
  
  # Make a chart for a symbol, with the settings from the inputs
  stock.sym <- reactive ({
    tryCatch({
      suppressWarnings(getSymbols(input$stock, auto.assign = FALSE))
    }, error = function(err) {
      return(NULL)
      })
  })
  
  symbol <- reactive ({
    input$stock
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

  output$OptionChain <- renderDataTable({
    invalidateLater(60000, session)
    OptionChain <- flipsideR:::getOptionChain(symbol())
    #OptionChain$retrieved = as.POSIXct(OptionChain$retrieved)
    colnames(OptionChain) <- c("Symbol", "Type", "Expiry", "Strike", "Premium", "Bid", "Ask", "Volume", "Open-Interest", "Time-Retrieved")
    OptionChain
    #write.csv(OptionChain, file = "OptionChain.csv")
    #UpdatedOptionChain <- reactiveFileReader(10000, session, 'OptionChain.csv', read.csv)
    #UpdatedOptionChain()
  })
  
  
#  output$opt.chain <- renderTable({

#    withProgress(message = "In Progress", 
#                 detail = "This may take a few seconds...", 
#                 value = 0, {for (i in 1:10) {
#                   incProgress(1/10)
#                   Sys.sleep(0.33)
#                 }
    
                  
#    detach("package:quantmod", unload=FALSE)    
#    require(flipsideR)
#    opt.price <- getOptionChain(symbol())
#    colnames(opt.price) <- c("Symbol", "Type", "Expiry", "Strike", "Premium", "Bid", "Ask", "Volume", "Open-Interest", "Time-Retrieved")
#    opt.price
#    })
#  })
    output$news <- renderText({
    if(!is.null(symbol())) {
      googlenews <- WebCorpus(GoogleNewsSource(symbol()))
      news.text <- lapply(aapl.googlenews[1:5], as.character)
      news.text
    }
  })
})
  
