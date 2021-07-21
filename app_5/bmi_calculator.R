library(shiny)
library(data.table)
library(randomForest)
library(shinythemes)

####################################
# User Interface                   #
####################################

ui <- fluidPage(theme = shinytheme("superhero"),
  navbarPage("BMI Calc:",
      tabPanel("1",
          sidebarPanel(
          tags$label(h2('Calculate ')),
          # stuff on the left aka input
          # HTML("<h2> BMI Calculator Inputs </h2>"),
          sliderInput("Height", label = "Height", min = 70, max = 300, value = median(c(70, 300))),
          sliderInput("Weight", label = "Weight", min = 35, max = 100, value = median(c(35, 100))),
          actionButton("submitbutton", "Submit", class = "btn btn-primary")
        ),
        mainPanel(
          # stuff in the middle aka output
          tags$label(h3('Status/Output')), # these 3 variables are all then used in the outputs in the server
          verbatimTextOutput('contents'), # aka 'contents' becomes -> output$contents
          tableOutput('tabledata')
        )
      ),
      tabPanel("2",
               titlePanel("About"),
               div(includeMarkdown("about.md"), align = "justify")
      )
  )
)

####################################
# Server                           #
####################################

server <- function(input, output, session) {
  # perform the function and track input data
    
  # this is the result that we print
  datasetInput <- reactive({
    bmi <- (input$Weight / (input$Height/100)^2)
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
  })
    
  # status/outupt text box
  output$contents <- renderPrint({
    if (input$submitbutton > 0) {
      isolate("Calculation complete.")
    } else {
      return("Server is ready for calculation")
    }
  })
  
  # prediction results table for bmi
  output$tabledata <- renderTable({
    if (input$submitbutton > 0) {
      isolate(datasetInput())
    }
  })
}

####################################
# Create Shiny App                 #
####################################
shinyApp(ui = ui, server = server)