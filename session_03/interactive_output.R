library(shiny)
library(ggplot2)
library(DT)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  titlePanel("Interactive outputs"),
  
  tabsetPanel(
    
    tabPanel(
      "Plots",
      class = "pt-2",
      fluidRow(
        column(3, selectInput("variable_x", "X variable:", names(mtcars))),
        column(3, selectInput("variable_y", "Y variable:", names(mtcars))),
        column(6),
      ),
      fluidRow(
        # Note the brush argument - this determines the ID of the brush results in
        # the server input object
        column(12, plotOutput("mtcars_plot", brush = "mtcars_plot_brush")),
      ),
      fluidRow(
        column(12, dataTableOutput("mtcars_table"))
      )
    ),
    
    tabPanel(
      "Tables",
      class = "pt-2",
      fluidRow(
        column(12, plotOutput("mtcars_plot2")),
      ),
      fluidRow(
        column(12, dataTableOutput("mtcars_table2"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Input data from plots ------------------------------------------------------
  
  # Plot the selected variables
  output$mtcars_plot <- renderPlot({
    ggplot(
      mtcars,
      aes(.data[[input$variable_x]], .data[[input$variable_y]])
    ) +
      geom_point()
  })
  
  output$mtcars_table <- renderDataTable({
    # The brushedPoints() helper filters a data frame based on the brush
    # selection from the plot element
    brushedPoints(
      mtcars,
      input$mtcars_plot_brush,
      input$variable_x,
      input$variable_y
    ) |> 
      # Create the datatable, disable row selections
      datatable(
        selection = "none"
      )
  })
  
  # Input data from DT tables --------------------------------------------------
  
  # The rows_selected input returns the indices of the selected rows. We can use
  # this to filter the data set.
  output$mtcars_plot2 <- renderPlot({
    if (length(input$mtcars_table2_rows_selected) > 0) {
      mtcars_sub <- mtcars[input$mtcars_table2_rows_selected, ]
    } else {
      mtcars_sub <- mtcars
    }
    
    ggplot(mtcars_sub, aes(wt, mpg)) + geom_point()
  })
  
  output$mtcars_table2 <- renderDataTable({
    # Create the datatable, enable multiple row selections
    datatable(
      mtcars,
      selection = "multiple"
    )
  })
}

shinyApp(ui, server)
