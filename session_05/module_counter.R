library(shiny)

#' Counter module UI
#'
#' @param id Module ID.
#' @param label Label for the counter button.
#'
#' @return A tagList containing counter module UI elements.
counterUI <- function(id, label = "Counter") {
  ns <- NS(id)
  
  tagList(
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

#' Counter module server
#'
#' @param id Module ID.
#' @param prefix Prefix for counter value text output.
#'
#' @return The counter as a reactive value.
counterServer <- function(id, prefix = NULL) {
  moduleServer(
    id,
    function(input, output, session) {
      count <- reactiveVal(0)
      
      observeEvent(input$button, {
        count(count() + 1)
      })
      
      output$out <- renderText({
        paste0(prefix, count())
      })
      
      count
    }
  )
}

#' Counter module application
#'
#' Create a simple example application using the counter module.
#' 
#' @param label Label for the counter button.
#' @param prefix Prefix for counter value text output.
#'
#' @return A shinyApp object
counterApp <- function(label = "Counter", prefix = "The current count is: ") {
  ui <- fluidPage(
    counterUI("counter", label),
  )
  
  server <- function(input, output, session) {
    counterServer("counter", prefix)
  }
  
  shinyApp(ui, server)
}
