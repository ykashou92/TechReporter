############
### ui.R ###
############

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("TechReporter"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("stock", "Symbol:", value = ""),
       submitButton(text = "Generate Report")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("mainPlot", height = "700px")
    )
  )
))
