library(shiny)
library(tibble)
library(ggplot2)

shinyUI(
  fluidPage(
    titlePanel("Analysis of two variables"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file", "Choose CSV File",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),

        htmlOutput("colname1"),
        htmlOutput("colname2"),
        #htmlOutput("alternative"),
        htmlOutput("methodname"),
        actionButton("submit", "Analyze")

      ),
      
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Table", tableOutput('table')),
                    tabPanel("Result", 
                             plotOutput("plot"),
                             verbatimTextOutput("sum"))

        )
      )
    )
  )
)