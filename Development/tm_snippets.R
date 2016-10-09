#`tm` Snippets

library(tm)
library(tm.plugin.webmining)

#AAPL example from GoogleFinanceSource
aapl.googlenews <- WebCorpus(GoogleFinanceSource("AAPL"))
aapl.googlenews
inspect(aapl.googlenews)
meta(aapl.googlenews[[1]])
writeLines(as.character(aapl.googlenews[[1]]))

#AAPL example from GoogleFinanceSource
spx.googlenews <- WebCorpus(GoogleFinanceSource("SPX"))
spx.googlenews
inspect(spx.googlenews)
meta(spx.googlenews[[1]])
writeLines(as.character(spx.googlenews[[1]]))

#MSFT example from YahooFinanceSource
msft.yahoonews <- WebCorpus(YahooNewsSource("Microsoft"))
msft.yahoonews
inspect(msft.yahoonews)
meta(msft.yahoonews[[1]])
writeLines(as.character(msft.yahoonews[[1]]))

#Google Earnings example from YahooFinanceSource
goog.yahoonews <- WebCorpus(YahooNewsSource("Google Earnings"))
goog.yahoonews
inspect(goog.yahoonews)
meta(goog.yahoonews[[2]])
writeLines(as.character(goog.yahoonews[[2]]))