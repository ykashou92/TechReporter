getSymbols("AAPL")
chartSeries(GOOG, subset = 'last 6 months', theme = chartTheme("white"))
addSMA(n = 200, col = "red")
addSMA(n = 50, col = "blue")
addSMA(n = 20, col = "yellow") 
addSMI()
addRSI()
addMACD()


# Plot theme
chartTheme('whitex', fg.col = "white", bg.col = "grey")

chartSeries(GOOG, 
            subset = 'last 6 months', 
            show.grid = FALSE,
            theme = chartTheme("white", 
                               up.col = "white", 
                               dn.col = "red", 
                               fg.col = "black", 
                               bg.col = "white"))
addRSI()
addMACD()


### START OF REACTIVE POLL
MyReact <- reactiveValues(df = data.frame(time = Sys.time()))
readTimeStamp <- function() {
  Sys.time()
}

readValue <- function() {
  data.frame(time = readTimeStamp())
}

data.chain <- reactivePoll(10000, session, readTimeStamp, readValue)

observe({
  myReact$df <- rbind(isolate(myReact$df), data.chain())
})

output$opt.chain <- renderTable({
  myReact$df
})
### END OF REACTIVE POLL

#tags$div(tags$style(".rightAlign{float:right;}")),
#div(
# style="display: inline-block", downloadButton('downloadChain', 'Export to CSV'), style = "float:right"


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

# Knitr Report Generator
output$downloadReport <- downloadHandler(
  filename = function() {
    paste('my-report', sep = '.', switch(
      input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
    ))
  },
  content = function(file2) {
    out <- render('report.Rmd', switch(
      input$format,
      PDF = pdf_document(), HTML = html_document(), Word = word_document()
    ))
  }
)

#OptionChain$retrieved = as.POSIXct(OptionChain$retrieved)
#write.csv(OptionChain, file = "OptionChain.csv")
#UpdatedOptionChain <- reactiveFileReader(10000, session, 'OptionChain.csv', read.csv)
#UpdatedOptionChain()

fileConn <- file("output.txt")
writeLines(as.character(googlenews[[1]] & googlenews[[2]]), fileConn)
file.show("output.txt")
close(fileConn)


#inspect(aapl.googlenews)
#meta(aapl.googlenews[[1]])

#fileConn <- file("output.txt")
#writeLines(as.character(googlenews[[1]]), fileConn)
#file.show("output.txt")
#close(fileConn)

#googlenews <- WebCorpus(GoogleFinanceSource(symbol()))
#x <- sapply(googlenews, function(x) {x$content})
#x2 <- sapply(googlenews[[2]], function(x) {x$content})

#x2
#as.data.frame(googlenews) %>%
#  with(., invisible(sapply(text, function(x) {strWrap(x);})))
#news.text.df = as.data.frame(do.call(rbind, news.text))
#write(news.text, "news.txt")
#news.pdf <- pdf(news.text)

#x <- sapply(googlenews, function(x) {x$content})
#x[[1]]

#x <- sapply(googlenews, function(x) {x$content})
#x[[1]]

