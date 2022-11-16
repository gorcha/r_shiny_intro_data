library(shiny)

ui <- fluidPage(
  numericInput("number", "Print me!", 10, min = 1, max = 20),
  textOutput("number_text"),
  actionButton("print", "Print")
)

server <- function(input, output, session) {
  number_string <- reactive({
    paste0("The number is: ", input$number)
  }) |>
    bindEvent(input$print)
  
  observe({
    print(number_string())
  }) |>
    bindEvent(input$print)
  
  output$number_text <- renderText({
    number_string()
  })
}

shinyApp(ui, server)
