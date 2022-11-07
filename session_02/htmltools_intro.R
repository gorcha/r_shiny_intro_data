library(htmltools)

ui <- tagList(
  tags$head(
    tags$title("My first page")
  ),
  tags$body(
    h1("My first heading"),
    p("My first paragraph, with some ", strong("bold"), " text."),
    div(
      id = "myDiv", class = "simpleDiv",
      "Here is a div with some attributes."
    )
  )
)

browsable(ui)
