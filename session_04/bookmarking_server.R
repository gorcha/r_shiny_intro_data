library(shiny)

ui <- function(request) {
  fluidPage(
    textInput("my_text", "Write some text here"),
    checkboxInput("my_checkbox", "Check me"),
    bookmarkButton()
  )
}

server <- function(input, output, session) { }

shinyApp(ui, server, enableBookmarking = "server")
