library(shiny)
library(tibble)
library(ggplot2)

shinyUI(
  fluidPage(
    titlePanel("Analysis of two variables by nonparametric method"),
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
        htmlOutput("alternative"),
        htmlOutput("methodname"),
        htmlOutput("sd_calc"),
        
        actionButton("submit", "Analyze")

      ),
      
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Table", tableOutput('table')),
                    tabPanel("Result", 
                             htmlOutput("plotmethod"),
                             plotOutput("plot"),
                             verbatimTextOutput("sum"),
                             verbatimTextOutput("sum_sd"))

        )
      )
    )
  )
)