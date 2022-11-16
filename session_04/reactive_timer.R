library(shiny)

ui <- fixedPage(
  h2("Random numbers at regular intervals"),
  p(
    "1000ms",
    textOutput("random_x")
  ),
  p(
    "500ms",
    textOutput("random_y"),
    textOutput("random_z")
  )
)

server <- function(input, output, session) {
  
  # invalidateLater() ----------------------------------------------------------
  
  # Invalidate a single expression
  output$random_x <- renderText({
    invalidateLater(1000)
    runif(1)
  })
  
  # reactiveTimer() ------------------------------------------------------------
  
  # Create a timer that can be used in multiple expressions
  my_timer <- reactiveTimer(500)
  
  output$random_y <- renderText({
    my_timer()
    runif(1)
  })
  
  output$random_z <- renderText({
    my_timer()
    runif(1)
  })
}

shinyApp(ui, server)
