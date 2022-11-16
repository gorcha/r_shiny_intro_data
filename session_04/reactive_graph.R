library(shiny)

ui <- fixedPage(
  textInput("input1", "Input 1"),
  textInput("input2", "Input 2"),
  textInput("input3", "Input 3"),
  
  textOutput("output1"),
  textOutput("output2"),
  textOutput("output3")
)

server <- function(input, output, session) {
  react1 <- reactive({
    input$input1
  })
  
  react2 <- reactive({
    paste(react1(), input$input2)
  })
  
  react3 <- reactive({
    paste(input$input2, input$input3)
  })
  
  output$output1 <- renderText({
    react2()
  })
  
  output$output2 <- renderText({
    react2()
  })
  
  output$output3 <- renderText({
    react3()
  })
}

reactlog::reactlog_enable()

shinyApp(ui, server)
