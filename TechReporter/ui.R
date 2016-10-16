############
### ui.R ###
############

shinyUI(dashboardPage(skin = "yellow",
  
  # Application title
  dashboardHeader(title = "TechReporter"),
      
  # Sidebar with a slider input for number of bins 
  dashboardSidebar(
    sidebarMenu(
      br(),
      textOutput("currentTime"),
      tags$style(type='text/css', "#currentTime { text-align: center; font-size: 20px; }"),
      br(),
      menuItem("TechReporter", tabName = "techreporter", icon = icon("dashboard")),
      menuItem("Technical Chart", tabName = "chart", icon = icon("line-chart")),
      menuItem("News", tabName = "news", icon = icon("feed")),
      menuItem("Option Prices", tabName = "options", icon = icon("list")),
      menuItem("Source Code", tabName = "sourcecode", icon = icon ("code")),
      textInput("stock", "Symbol:", value = "GOOG"),
      tags$style(type="text/css", "#stock { height: 50px; width: 100%; text-align:center; font-size: 30px;}"),
      #sliderInput()
      submitButton("Generate Report", width = "230px"),
      br(),
      radioButtons('format', 'Document format', c('PDF', 'HTML', 'Word'),
                   inline = TRUE),
      column(width = 12, align="center", 
             downloadButton('downloadReport', 'Download Report') 
      )
    )),
  
    dashboardBody(
      tabItems(
        tabItem(tabName = "techreporter",
                h2("Welcome to TechReporter", align = "center"),
                br(),
                p("To use this tool, please type in a stock symbol in the sidebar such as AAPL, GOOG or MSFT and press `Generate Report`", align = "center"),
                p("Then proceed to the other tabs to check out the technical chart, related news and an updated option chain.", align = "center")),
        tabItem(tabName = "chart",
                h2("Technical Chart", align = "center"),
                plotOutput("mainPlot", height = "700px")),
        tabItem(tabName = "news",
                h2("News", align = "center"),
                textOutput("news")),
                #includeText("mycorpus.txt"),
        tabItem(tabName = "options",
                h2("Option Chain", align = "center"),
                p("Below is the option chain of your selected stock, it automatically updates every 60 seconds to provide you with fresh prices.", align = "center"),
                column(width = 12, align="center", 
                       downloadButton("downloadChain", 'Export to CSV') 
                ),
                dataTableOutput("OptionChain"))
                
      )
    )
  )
)

