#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# install.packages('shiny')
# install.packages('shinythemes')

# Load R packages
library(shiny)
data(airquality)

# Define UI
ui <- fluidPage(
  
  # app title
  titlePanel("Wind Level!"),
  
  # sidebar layouts
  sidebarLayout(
    
    #sidebar panel
    sidebarPanel(
      
      #Input: Slider for bins
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 0,
                  max = 25,
                  value = 10,
                  step = 5)
    ),
    
    #Main panel for OUTPUTS
    mainPanel(
      
      #Output a histogram; this becomes an object attached to Output
      plotOutput(outputId = "distPlot")

    )
  )
)

# Define server function  
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    x <- airquality$Wind
    x <- na.omit(x)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "red", border = "black",
         xlab = "Wind level",
         main = "Histogram of Wind level")
  })
} 


# Create Shiny object
shinyApp(ui = ui, server = server)