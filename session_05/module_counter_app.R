library(shiny)

source("module_counter.R", local = TRUE)

ui <- fixedPage(
  headerPanel("Counters"),
  fixedRow(
    column(6, counterUI("counter")),
    column(6, counterUI("counter2", "My 2nd counter"))
  )
)

server <- function(input, output, session) {
  counterServer("counter")
  
  counterServer("counter2")
}

shinyApp(ui, server)
