library(shiny)
library(DT)

ui <- fixedPage(
  themes = bslib::bs_theme(version = 5),
  titlePanel("DataTables"),
  
  tabsetPanel(
    tabPanel("Defaults", dataTableOutput("table_default")),
    tabPanel("Simple customisation", dataTableOutput("table_custom")),
    tabPanel("Extensions - buttons", dataTableOutput("table_buttons")),
    tabPanel("Formatting", dataTableOutput("table_format"))
  )
)

server <- function(input, output, session) {
  # A simple data table using the default options
  output$table_default <- renderDataTable({
    datatable(mtcars)
  })
 
  # DT is extremely customisable
  # This example turns off all of the default interactive components and uses a
  # simple hover class for styling
  output$table_custom <- renderDataTable({
    datatable(
      mtcars,
      class = "hover",
      selection = "none",
      options = list(
        info = FALSE,
        ordering = FALSE,
        paging = FALSE,
        searching = FALSE
      )
    )
  })
  
  # DT has many extensions - see the docs for details
  # This example adds buttons to allow users to copy or export data from the
  # table
  output$table_buttons <- renderDataTable({
    datatable(
      mtcars,
      selection = "none",
      extensions = "Buttons",
      options = list(
        buttons = c("copy", "csv", "excel", "pdf", "print"),
        dom = "Bfrtip"
      )
    )
  })
  
  # Add formatting and styling using styling helper functions
  # This includes overall column formatting and value based styling
  output$table_format <- renderDataTable({
    datatable(mtcars) |>
      formatRound(1:7) |>
      formatStyle(
        "disp",
        background = styleColorBar(mtcars$disp, "steelblue")
      ) |>
      formatStyle(
        "drat",
        color = styleInterval(c(3.08, 3.92), c("white", "blue", "red")),
        backgroundColor = styleInterval(3.597, c("gray", "yellow"))
      )
  })
}

shinyApp(ui, server)
