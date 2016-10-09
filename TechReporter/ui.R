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
      menuItem("TechReporter", tabName = "techreporter", icon = icon("bar-chart")),
      menuItem("Source Code", tabName = "sourcecode", icon = icon ("code"))
      
    )),
    dashboardBody(
      tabItems(
        tabItem(tabName = "overview",
                h2("Overview")
        ),
        tabItem(tabName = "techreporter",
                h2("TechReporter"),
                wellPanel(
                  textInput("stock", "Symbol:", value = ""),
                  submitButton(text = "Generate Report")
                  ),
                br(),
                plotOutput("mainPlot", height = "700px")
        )
    )
  )
)
)

