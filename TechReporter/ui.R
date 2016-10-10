############
### ui.R ###
############

# Define UI for application that draws a histogram
shinyUI(dashboardPage(skin = "red",
  
  # Application title
  dashboardHeader(title = "TechReporter"),
  
  # Sidebar with a slider input for number of bins 
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("TechReporter", tabName = "techreporter", icon = icon("bar-chart"),
               menuSubItem("Generator", tabName  = "generator", icon = icon("gear")),
               menuSubItem("Chart", tabName = "chart", icon = icon("line-chart")),
               menuSubItem("News", tabName = "news", icon = icon("feed")),
               menuSubItem("Options Prices", tabName = "options", icon = icon("list"))),
      menuItem("Source Code", tabName = "sourcecode", icon = icon ("code"))
      
    )),
    dashboardBody(
      tabItems(
        tabItem(tabName = "overview",
                h2("Overview")
        ),
        tabItem(tabName = "generator",
                h2("Welcome to the Generator"),
                br(),
                h3("Instructions"),
                p("To use this tool, please type in a stock symbol such as AAPL, GOOG or MSFT and press `Generate Report`"),
                p("Then proceed to the other tabs to check out the technical chart, related news and updated option prices."),
                wellPanel(
                  textInput("stock", "Symbol:", value = "", width = "200px"),
                  submitButton(text = "Generate Report", width = "200px")
                  )),
        tabItem(tabName = "chart",
                h2("Chart"),
                plotOutput("mainPlot", height = "700px"))
      )
    )
  )
)

