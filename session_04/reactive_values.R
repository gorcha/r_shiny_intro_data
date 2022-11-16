library(shiny)

ui <- fixedPage(
  textInput("text_a", "Text box 'a'"),
  textInput("text_b", "Text box 'b'"),
  textOutput("count_a"),
  textOutput("count_b"),
  textOutput("count_total")
)

server <- function(input, output, session) {
  
  # Count the number of changes in our inputs ----------------------------------
  
  # A single reactive value
  input_text_change <- reactiveVal(0)
  
  # A list of multiple reactive values
  input_change <- reactiveValues(a = 0, b = 0)
  
  # Update the change count for input a and the total when text_a changes
  observe({
    input_change$a <- input_change$a + 1
    input_text_change(input_text_change() + 1)
  }) |>
    bindEvent(input$text_a)
  
  # Update the change count for input b and the total when text_b changes
  observe({
    input_change$b <- input_change$b + 1
    input_text_change(input_text_change() + 1)
  }) |>
    bindEvent(input$text_b)
  
  # Render the counter values --------------------------------------------------
  
  output$count_a <- renderText({
    paste("Text box 'a' has changed", input_change$a, "times")
  })
  
  output$count_b <- renderText({
    paste("Text box 'b' has changed", input_change$b, "times")
  })
  
  output$count_total <- renderText({
    paste("Text boxes have changed", input_text_change(), "times")
  })
}

shinyApp(ui, server)
