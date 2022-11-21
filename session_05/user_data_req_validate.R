library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  
  fixedRow(
    class = "m-4",
    column(3,
      selectInput("dataset", "Dataset", choices = ls("package:datasets")),
      textInput("variable", "Variable"),
    ),
    column(9,
      span(
        class = "text-centre align-middle",
        verbatimTextOutput("summary")
      )
    )
  ),
  fixedRow(
    class = "m-4",
    column(12, tableOutput("table"))
  )
)

server <- function(input, output, session) {
  # Return the selected dataset
  dataset <- reactive({
    dataset <- as.data.frame(get(input$dataset, "package:datasets"))
  })
  
  # Render selected dataset
  output$table <- renderTable({
    dataset()
  })
  
  # Render a summary of the selected variable
  output$summary <- renderPrint({
    # Don't run if a dataset hasn't been select
    req(dataset())
    
    # Return an error message if the selected variable isn't in dataset()
    validate(
      need(
        input$variable %in% names(dataset()),
        "Select a valid variable"
      )
    )
    
    summary(dataset()[input$variable])
  })
}

shinyApp(ui, server)
