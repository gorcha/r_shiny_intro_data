library(shiny)

ui <- navbarPage(
  "My Application",
  fluid = FALSE,
  tabPanel(
    "Tabset",
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table", tableOutput("table"))
    )
  ),
  tabPanel(
    "Navlist",
    navlistPanel(
      tabPanel("Plot", plotOutput("plot2")),
      tabPanel("Summary", verbatimTextOutput("summary2")),
      tabPanel("Table", tableOutput("table2"))
    )
  ),
  navbarMenu(
    "More",
    tabPanel("Sub-Component A"),
    tabPanel("Sub-Component B")
  )
)

shinyApp(ui, function(input, output, session) { })
