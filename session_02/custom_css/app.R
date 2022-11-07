library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  fluidRow(
    column(6, class = "red-div", "Red background"),
    column(6, class = "green-div", "Green Background")
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
