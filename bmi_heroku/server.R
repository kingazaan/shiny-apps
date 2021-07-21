library(data.table)
library(randomForest)

####################################
# Server                           #
####################################

shinyServer <- function(input, output, session) {
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