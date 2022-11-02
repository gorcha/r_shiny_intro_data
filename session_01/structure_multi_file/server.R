library(shiny)

server <- function(input, output, session) {
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}
