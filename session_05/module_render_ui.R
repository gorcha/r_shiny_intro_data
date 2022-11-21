
library(shiny)

#' Dynamic table module UI
#'
#' @param id Module ID.
#'
#' @return A tagList containing module UI elements.
dynamicTableUI <- function(id) {
  ns <- NS(id)
  tagList(
    checkboxInput(ns("render_ui"), "Render UI?"),
    uiOutput(ns("custom_ui"))
  )
}

#' Dynamic table module server
#'
#' @param id Module ID.
#' 
dynamicTableServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$custom_ui <- renderUI({
        if (input$render_ui) {
          tagList(
            selectInput(session$ns("dataset"), label = "Dataset", choices = ls("package:datasets")),
            tableOutput(session$ns("table"))
          )
        } else {
          NULL
        }
      })
      
      output$table <- renderTable({
        dataset <- get(input$dataset, "package:datasets")
        dataset
      })
    }
  )
}

#' Dynamic table module application
#'
#' Create a simple example application using the dynamic table module.
#' 
#' @return A shinyApp object
dynamicTableApp <- function() {
  ui <- fluidPage(
    dynamicTableUI("dynamic_table")
  )
  
  server <- function(input, output, session) {
    dynamicTableServer("dynamic_table")
  }
  
  shinyApp(ui, server)
}
