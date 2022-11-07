library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  div(
    # Center all text in the div
    class = "container text-center",
    h1(class = "display-3", "Bootstrap grid"),
    
    # Applying the classes "bg-light" and "border" to each column adds styling
    
    tabsetPanel(
      tabPanel(
        "Grid",
        h4("Grid"),
        # `column()` takes the column width as the first argument.
        # The total widths of columns in each row should add up to 12
        fixedRow(
          column(3, class = "bg-light border", "1 of 4"),
          column(3, class = "bg-light border", "2 of 4"),
          column(3, class = "bg-light border", "3 of 4"),
          column(3, class = "bg-light border", "4 of 4")
        ),
        fixedRow(
          column(4, class = "bg-light border", "1 of 3"),
          column(4, class = "bg-light border", "2 of 3"),
          column(4, class = "bg-light border", "3 of 3")
        ),
        # Use different combinations of widths to relatively space columns
        fixedRow(
          column(4, class = "bg-light border", "1 of 3"),
          column(2, class = "bg-light border", "2 of 3"),
          column(6, class = "bg-light border", "3 of 3")
        ),
        fixedRow(
          column(6, class = "bg-light border", "1 of 2"),
          column(6, class = "bg-light border", "2 of 2")
        ),
        
        h4("Underflow/overflow"),
        # Columns in each row should add up to 12
        # If they're less than 12, the remainder is whitespace
        fixedRow(
          column(4, class = "bg-light border", "1 of 2"),
          column(4, class = "bg-light border", "2 of 2 - underflow")
        ),
        # If they're more than 12, the final column will overflow on to another row
        fixedRow(
          column(6, class = "bg-light border", "1 of 2"),
          column(8, class = "bg-light border", "2 of 2 - overflow")
        ),
        
        h4("Nested rows and columns"),
        # Rows and columns can be nested. Like normal rows, nested rows contain
        # columns with widths adding up to 12
        fixedRow(
          column(
            4, class = "bg-light border",
            fixedRow(
              column(6, class = "bg-light border", "1 of 2"),
              column(6, class = "bg-light border", "2 of 2")
            )
          ),
          column(
            8, class = "bg-light border",
            fixedRow(
              column(4, class = "bg-light border", "1 of 3"),
              column(4, class = "bg-light border", "2 of 3"),
              column(4, class = "bg-light border", "3 of 3")
            ),
            fixedRow(
              column(3, class = "bg-light border", "1 of 4"),
              column(3, class = "bg-light border", "2 of 4"),
              column(3, class = "bg-light border", "3 of 4"),
              column(3, class = "bg-light border", "4 of 4")
            )
          )
        ),
        
        h4("Utility classes - padding and colour"),
        # Add utility classes for additional styling
        fixedRow(
          column(4, class = "p-2 bg-info border", "1 of 3"),
          column(4, class = "p-2 bg-light border", "2 of 3"),
          column(4, class = "p-2 bg-warning border", "3 of 3")
        )
      ),
      tabPanel(
        "Components",
        h4("With components"),
        fixedRow(
          column(4, textInput("my_text", "Write something here")),
          column(4, selectInput("my_select", "Select an option", c("option 1", "option 2"))),
          column(4, actionButton("my_button", "Do some stuff")),
        ),
        fixedRow(
          column(8, textAreaInput("my_textarea", "Write something a bit longer", width = "100%")),
          column(4, radioButtons("my_radio", "Select an option", c("option 1", "option 2")))
        )
      )
    )
  )
)

shinyApp(ui, function(input, output, session) { })
