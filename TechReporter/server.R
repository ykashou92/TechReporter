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
addSMI(n = 3, fas = 3, slow = 14); addSMA(n = 200, col = 'navy');
addSMA(n = 50, col = 'green')"
    
    if(!is.null(stock.sym())) {
    chartSeries(stock.sym(),
                name = input$stock,
                subset = 'last 6 months', 
                TA = TA.indicators,
                theme = chartTheme("white",
                                   up.col = "blue", 
                                   dn.col = "red", 
                                   fg.col = "black", 
                                   bg.col = "#ECF0F5",
                                   grid.col = "black",
                                   border = "pink"))
    }
  })
  #87CEE
  output$OptionChain <- renderDataTable({
    invalidateLater(60000, session)
    opt.chain <- flipsideR:::getOptionChain(symbol())
    #OptionChain$retrieved = as.POSIXct(OptionChain$retrieved)
    colnames(opt.chain) <- c("Symbol", "Type", "Expiry", "Strike", "Premium", "Bid", "Ask", "Volume", "Open-Interest", "Time-Retrieved")
    
    #write.csv(OptionChain, file = "OptionChain.csv")
    #UpdatedOptionChain <- reactiveFileReader(10000, session, 'OptionChain.csv', read.csv)
    #UpdatedOptionChain()
    
    # Option Chain Download Button
    output$downloadChain <- downloadHandler(
      filename = function() { paste(symbol(), '-option-chain-', Sys.time(), '.csv', sep = '') 
      },
      content = function(file) {
        write.csv(opt.chain, file)})
    opt.chain
     })

    output$news <- renderText({
    if(!is.null(symbol())) {
      googlenews <- WebCorpus(GoogleNewsSource(symbol()))
      news.text <- lapply(aapl.googlenews[1:5], as.character)
      news.text
    }
  })
})
  
