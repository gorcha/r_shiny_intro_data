library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  h1("Dynamically update inputs"),
  tabsetPanel(
    tabPanel(
      "Update values",
      fixedRow(
        class = "m-4",
        column(6,
          checkboxInput("my_checkbox", "Check me"),
          actionButton("toggle_checkbox", "Toggle checkbox")
        ),
        column(6,
          textInput("my_text", "Write some text here"),
          sliderInput("my_slider", "Slide me", 0, 20, 10),
          actionButton("clear_text", "Clear text")
        )
      )
    ),
    tabPanel(
      "Update options",
      fixedRow(
        class = "m-4",
        column(3,
          selectInput("dataset", "Dataset", choices = ls("package:datasets")),
          selectInput("variable", "Variable", choices = c()),
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
  )
)

server <- function(input, output, session) {
  
  ## Update values
  
  # Toggle the checkbox on button press
  observe({
    updateCheckboxInput(session, "my_checkbox", value = !input$my_checkbox)
  }) |>
    bindEvent(input$toggle_checkbox)

  # Set the value of the text box based on the slider input  
  observe({
    updateTextInput(session, "my_text", value = paste("Sliding on over to", input$my_slider))
  })
  
  # Clear the text box on button press
  observe({
    updateTextInput(session, "my_text", value = "")
  }) |>
    bindEvent(input$clear_text)
  
  ## Update options
  
  # Return the selected dataset
  dataset <- reactive({
    dataset <- as.data.frame(get(input$dataset, "package:datasets"))
  })
  
  # Update the select input choices based on variables in the selected dataset
  observe({
    updateSelectInput(session, "variable", choices = names(dataset()))
  })
  
  # Render selected dataset
  output$table <- renderTable({
    dataset()
  })
  
  # Render a summary of the selected variable
  output$summary <- renderPrint({
    # Don't run if a dataset and variable have been selected
    req(input$variable)
    req(dataset())
    
    # Only return a summary if the selected variable is included in dataset()
    if (!input$variable %in% names(dataset())) return("")
    
    summary(dataset()[input$variable])
  })
}

shinyApp(ui, server)
