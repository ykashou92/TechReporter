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


