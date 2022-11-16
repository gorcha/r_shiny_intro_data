library(shiny)

ui <- fluidPage(
  p(
    numericInput("number", "Print me!", 10, min = 1, max = 20),
    textOutput("number_text"),
    actionButton("print", "Print")
  ),
  p(
    textOutput("count_change")
  )
)

server <- function(input, output, session) {
  
  # The reference to input$number is wrapped in isolate(), so renderText() will
  # only re-execute when input$print changes. This is essentially how
  # bindEvent(input$print) works
  output$number_text <-  renderText({
    input$print
    
    isolate({
      paste0("The number is: ", input$number)
    })
  })
  
  # If we don't isolate number_change$count we will create a circular
  # dependency! number_change$count would be a dependency for the observer, so
  # it would re-execute very time it increments itself
  number_change <- reactiveValues(count = 0)
  
  observe({
    input$number
    number_change$count <- isolate(number_change$count) + 1
  })
  
  output$count_change <- renderText({
    paste("Number has changed", number_change$count, "times")
  })
}

shinyApp(ui, server)
