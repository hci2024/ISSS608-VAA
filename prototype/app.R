#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
library(shiny)
library(tidyverse)

exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Pupils Examination Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "variable", # must be unique
        label = "Subject: ",
        choices = c("English" = "ENGLISH",
                    "Science" = "SCIENCE",
                    "Maths" = "MATHS"),
        selected = "English"),
      sliderInput(inputId = "bins",
                  label = "Number of bins",
                  min = 5,
                  max = 20,
                  value = 10)
        ),
    mainPanel(plotOutput("distPlot"))
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    ggplot(data = exam, 
           aes_string(x = input$variable)) +
      geom_histogram(bins = input$bins,
                     color = "black",
                     fill = "light blue")
  })
}

shinyApp (ui=ui, server=server)