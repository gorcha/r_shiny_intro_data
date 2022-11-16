library(shiny)

ui <- fixedPage(
  h2("Working with the session object"),
  
  tabsetPanel(
    tabPanel(
      "Query string",
      p(
        h4("Update the query string"),
        textInput("query_text", "Enter new query string"),
        helpText("Format: ?param1=val1&param2=val2"),
        actionButton("update_query", "Update query string")
      ),
      p(
        h4("Query string values"),
        verbatimTextOutput("query")
      )
    ),
    
    tabPanel(
      "clientData",
      p(
        h4("URL info"),
        verbatimTextOutput("url_info")
      ),
      p(
        h4("Pixel ratio"),
        verbatimTextOutput("pixelratio")
      )
    ),
    
    tabPanel(
      "userData",
      p(
        h4(""),
        textInput("my_variable_text", "Enter value for my_variable"),
        verbatimTextOutput("my_variable"),
        actionButton("print_my_variable", "Print value")
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Query string ---------------------------------------------------------------
  
  observe({
    updateQueryString(input$query_text, mode = "push")
  }) |>
    bindEvent(input$update_query)
  
  # Render query string parameters
  output$query <- renderText({
    query <- getQueryString()
    
    query_text <- paste(names(query), query, sep = "=", collapse = ", ")
    paste("Query string values are:\n", query_text)
  })
  
  # clientData -----------------------------------------------------------------
  
  # Extract URL information components from clientData
  output$url_info <- renderText({
    url_names <- names(session$clientData)[grepl("^url_", names(session$clientData))]
    
    url_info <- sapply(url_names, function(x) session$clientData[[x]])
    
    paste(names(url_info), url_info, sep = ": ", collapse = "\n")
  })
  
  # Get the evice pixel ratio
  output$pixelratio <- renderText({
    session$clientData$pixelratio
  })
  
  # userData -------------------------------------------------------------------
  
  observe({
    session$userData$my_variable <- input$my_variable_text
  })
  
  # userData is not reactive, so we need to use a different trigger to print the
  # updated value
  output$my_variable <- renderText({
    input$print_my_variable
    
    session$userData$my_variable
  })
}

shinyApp(ui, server)
