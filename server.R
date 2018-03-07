
source("atv.R")

server <- function(input, output, session) {
  observeEvent(input$file, {
    
    csv_file <- reactive(read.csv(input$file$datapath))
    output$table <- renderTable(head(csv_file(), n = 30))
    
    output$colname1 <- renderUI({ 
      selectInput("x", "x-axes", colnames(csv_file()))
    })
    output$colname2 <- renderUI({ 
      selectInput("y", "y-axes", colnames(csv_file()))
    })
    

  })

  observeEvent(input$submit, {
    #name <- names(input$file)
    csv_file <- reactive(read.csv(input$file$datapath))
    
    output$methodname <- renderUI({ 
      selectInput("method", "Method", 
                  choices = result()$method)
    })



    csv_x <- reactive(csv_file()[input$x])
    csv_y <- reactive(csv_file()[input$y])
    
    result <- reactive(atv(x = csv_x()[, 1], y = csv_y()[, 1]))
    
    output$plot <- renderPlot({plot(result())})
    
    output$sum <- renderPrint({summary(result(), method = input$method)})
    
    #output$pvalue <- renderText({paste0("p = ",format(result()$p.value, digits = 4))})

  })
}



