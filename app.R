#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# install.packages('shiny')
# install.packages('shinythemes')

# Load R packages
library(shiny)
library(shinythemes)


# Define UI
ui <- fluidPage(theme = shinytheme("superhero"),
                navbarPage(
                    # theme = "cerulean",  # <--- To use a theme, uncomment this
                    "My first app",
                    tabPanel("Navbar 1",
                             sidebarPanel(
                                 tags$h3("Input:"),
                                 textInput("txt1", "Given Name:", ""), # txt1 sent to the server
                                 textInput("txt2", "Surname:", ""),    # txt2 sent to the server
                                 
                             ), # sidebarPanel
                             mainPanel(
                                 h1("Header 1"),
                                 
                                 h4("Output 1"),
                                 verbatimTextOutput("txtout"), # generated from the server
                                 
                             ) # mainPanel
                             
                    ), # Navbar 1, tabPanel
                    tabPanel("Navbar 2", "This panel is intentionally left blank"),
                    tabPanel("Navbar 3", "This panel is intentionally left blank")
                    
                ) # navbarPage
) # fluidPage


# Define server function  
server <- function(input, output) {
    
    output$txtout <- renderText({
        paste( input$txt1, input$txt2, sep = " " ) # this is where the input + output happens
    })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)