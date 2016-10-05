getSymbols("AAPL")
chartSeries(GOOG, subset = 'last 6 months', theme = chartTheme("white"))
addSMA(n = 200, col = "red")
addSMA(n = 50, col = "blue")
addSMA(n = 20, col = "yellow") 
addSMI()
addRSI()
addMACD()


# Plot theme
chchartTheme('whitex', fg.col = "white", bg.col = "grey")

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