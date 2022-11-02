library(shiny)

ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  tableOutput("table")
)

server <- function(input, output, session) {
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

app <- shinyApp(ui, server)
runApp(app)
