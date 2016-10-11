library(RCurl)
library(XML)

url <- readHTMLTable(url, stringsAsFactors = FALSE)

call_tab <- tabs[[11]]
put_tab <- tabs[[15]]

doc <- htmlTreeParse(url, useInternalNodes = TRUE)

tab_nodes <- xpathApply(doc, "//table[@cellpadding = '3']")

tabs <- lapply(tab_nodes, readHTMLTable)
names(tabs) = c("Calls", "Puts")

AAPL.OPT <- getOptionChain("AAPL")



l