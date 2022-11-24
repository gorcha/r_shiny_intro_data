library(shiny)

# Select dataset module --------------------------------------------------------

#' Dataset selection module UI
#'
#' @param id Module ID.
#'
#' @return A tagList containing module UI elements.
selectDatasetUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("dataset"), "Dataset", choices = ls("package:datasets"))
  )
}

#' Dataset selection module server
#'
#' @param id Module ID.
#'
#' @return A list containing the selected dataset and its name as reactive
#'   objects.
#' \describe{
#'   \item{data}{Selected dataset as a reactive object}
#'   \item{name}{Dataset name as a reactive string}
#' }
selectDatasetServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      dataset <- reactive({
        dataset <- as.data.frame(get(input$dataset, "package:datasets"))
      })
      
      list(
        data = dataset,
        name = reactive(input$dataset)
      )
    }
  )
}

# Select variable module -------------------------------------------------------

#' Variable selection module UI
#'
#' @param id Module ID.
#'
#' @return A tagList containing module UI elements.
selectVariableUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("variable"), "Variable", choices = c())
  )
}

#' Variable selection module server
#'
#' @param id Module ID.
#' @param dataset A reactive expression containing the dataset to select a
#'   variable from.
#'
#' @return The selected variable as a reactive object.
selectVariableServer <- function(id, dataset) {
  moduleServer(
    id,
    function(input, output, session) {
      observe({
        updateSelectInput(
          session,
          "variable",
          choices = names(dataset())
        )
      })
      
      reactive(input$variable)
    }
  )
}

# Nesting modules --------------------------------------------------------------

#' Dataset and variable selection module UI
#'
#' @param id Module ID.
#'
#' @return A tagList containing module UI elements.
selectDataVarUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectDatasetUI(ns("dataset_select")),
    selectVariableUI(ns("variable_select")),
    
    verbatimTextOutput(ns("module_out"), placeholder = TRUE),
    tableOutput(ns("table"))
  )
}

#' Dataset and variable selection module server
#'
#' @param id Module ID.
#'
#' @return A list containing the selected dataset and variable as reactive
#'   objects.
#' \describe{
#'   \item{data}{Selected dataset as a reactive object}
#'   \item{name}{Dataset name as a reactive string}
#'   \item{var}{Selected variable as a reactive string}
#' }
selectDataVarServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      dataset <- selectDatasetServer("dataset_select")
      
      variable <- selectVariableServer("variable_select", dataset$data)
      
      output$module_out <- renderText({
        paste0(
          "Selected variable `", variable(), "` ",
          "from dataset `", dataset$name(), "`"
        )
      })
      
      output$table <- renderTable({
        dataset$data()
      })
      
      list(
        data = dataset$data,
        name = dataset$name,
        var = variable
      )
    }
  )
}

# Application ------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("Data selectors"),
  fluidRow(
    column(6, selectDataVarUI("data")),
    column(6, selectDataVarUI("data2"))
  )
)

server <- function(input, output, session) {
  selectDataVarServer("data")
  selectDataVarServer("data2")
}

shinyApp(ui, server)
