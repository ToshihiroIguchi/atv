
source("atv.R")
source("Steel_Dwass.R")

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
    
    output$alternative <- renderUI({
      selectInput("alternative", "Alternative",
                  choices = c("two.sided", "less", "greater")
                  )
                    
    })
    
    output$methodname <- renderUI({ 
      selectInput("method", "Method", 
                  choices = result()$method)
    })
    
    output$sd_calc <- renderUI({
      checkboxInput("sd_calc", "Steel-Dwass' test", value = FALSE)
    })
    
    output$plotmethod <- renderUI(({
      selectInput("plotmethod", "Plot",
                  choices = if(!is.null(result()$aov)){
                    c("point", "violin", "boxplot")
                    })
    }))



    csv_x <- reactive(csv_file()[input$x])
    csv_y <- reactive(csv_file()[input$y])
    
    result <- reactive(atv(x = csv_x()[, 1], y = csv_y()[, 1],
                           alternative = input$alternative))
    
    output$plot <- renderPlot({plot(result(), 
                                    xlab = input$x, ylab = input$y,
                                    geom = input$plotmethod)})
    
    output$sum <- renderPrint({summary(result(), method = input$method)})
    
    output$sum_sd <- renderPrint({
      Steel_Dwass(x = csv_y()[, 1], g = csv_x()[, 1], 
                  result(), calc = input$sd_calc)
    })
    
    #output$pvalue <- renderText({paste0("p = ",format(result()$p.value, digits = 4))})

  })
}




