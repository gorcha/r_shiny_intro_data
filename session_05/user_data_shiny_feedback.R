library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  # Enable shinyFeedback features
  useShinyFeedback(),
  
  numericInput(
    "positive_number",
    "Enter a number",
    value = -5
  )
)

server <- function(input, output, session) {
  # Watch the value of the input control and provide user feedback if needed
  observe({
    if (input$positive_number < 0) {
      showFeedbackWarning(
        "positive_number",
        "Please enter a positive number"
      )
    } else {
      hideFeedback("positive_number")
    }
  }) |>
    bindEvent(input$positive_number)
}

shinyApp(ui, server)
