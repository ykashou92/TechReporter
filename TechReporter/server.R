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
    TA.indicators = "addVo(); addBBands(); addMACD(histogram = TRUE); addRSI(); 
addSMI(n = 3, fas = 3, slow = 14); addSMA(n = 200, col = 'orange');
addSMA(n = 50, col = 'navy')"
    
    if(!is.null(stock.sym())) {
    p <- chartSeries(stock.sym(),
                name = input$stock,
                subset = 'last 6 months', 
                TA = TA.indicators,
                theme = chartTheme("white",
                                   up.col = "#29A6DA", 
                                   dn.col = "red", 
                                   fg.col = "black", 
                                   bg.col = "#ECF0F5",
                                   grid.col = "black",
                                   border = "pink"))
    }
    p
    dev.copy(png, 'myplot.png', width = 800)
    dev.off()
    
  })
  
  output$OptionChain <- renderDataTable({
    invalidateLater(60000, session)
    opt.chain <- flipsideR:::getOptionChain(symbol())
    colnames(opt.chain) <- c("Symbol", "Type", "Expiry", "Strike", "Premium", "Bid", "Ask", "Volume", "Open-Interest", "Time-Retrieved")
    
    # Option Chain Download Button
    output$downloadChain <- downloadHandler(
     filename = function() { paste(symbol(), '-option-chain-', Sys.time(), '.csv', sep = '') 
      },
      content = function(file) {
        write.csv(opt.chain, file)})
    opt.chain
     })
  
  
  output$downloadReport <- downloadHandler(
    filename = function() { paste(symbol(), '-news-report', Sys.time(), '.txt', sep = '') 
    },
      
    content = function(file) {
        googlenews <- WebCorpus(GoogleFinanceSource(symbol()))
        x <- sapply(googlenews, function(x) {x$content})
        #writeCorpus(out, "outputdir/", filenames = "corpus.txt")
        
        #news.text <- lapply(googlenews[1:5], as.character)
        #news.report <- writeCorpus(news.text)
      })

  #file.create("mycorpus.txt")
  
  #pdf(tech.report, file)
    
    output$news <- renderText({
      googlenews <- WebCorpus(GoogleFinanceSource(symbol()))
      x <- sapply(googlenews, function(x) {x$content})
      #googlenews <- WebCorpus(GoogleFinanceSource(symbol()))
      #x <- sapply(googlenews, function(x) {x$content})
      #x2 <- sapply(googlenews[[2]], function(x) {x$content})
      x[[1]]
      #x2
      #as.data.frame(googlenews) %>%
      #  with(., invisible(sapply(text, function(x) {strWrap(x);})))
      #news.text.df = as.data.frame(do.call(rbind, news.text))
      #write(news.text, "news.txt")
      #news.pdf <- pdf(news.text)
    #}
  })
})
  
