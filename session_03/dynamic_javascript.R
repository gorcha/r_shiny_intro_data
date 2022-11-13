library(shiny)

# Create a button group. See the HTML example in the Bootstrap docs:
# https://getbootstrap.com/docs/5.2/components/button-group/
buttonGroup <- function(..., class = "") {
  div(
    class = paste("btn-group", class),
    role = "group",
    ...
  )
}

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  shinyjs::useShinyjs(),
  
  titlePanel("shinyjs"),
  
  h4("Built-in functions"),
  fluidRow(
    column(12,
      buttonGroup(
        actionButton("js_toggle_enabled", "Enable/disable"),
        actionButton("js_toggle_visible", "Show/hide")
      )
    )
  ),
  fluidRow(
    class = "pt-2",
    column(12, textInput("text", "Text"))
  ),
  
  h4("CSS classes"),
  fluidRow(
    column(3, actionButton("js_button_style", "Style me!")),
    column(3,
      checkboxGroupInput(
        "js_class",
        "Button styling",
        c("Primary" = "primary", "Large" = "large")
      )
    ),
    column(6)
  ),
  
  h4("Run JavaScript"),
  fluidRow(
    column(3, actionButton("js_message", "What's the time?")),
    column(9)
  )
)

server <- function(input, output) {
  
  # Change UI attributes on button press ---------------------------------------
  
  observe({
    shinyjs::toggleState("text")
  }) |>
    bindEvent(input$js_toggle_enabled)

  observe({
    shinyjs::toggle("text")
  }) |>
    bindEvent(input$js_toggle_visible)
  
  
  # Add/remove CSS classes -----------------------------------------------------
  
  observe({
    shinyjs::toggleClass(
      id = "js_button_style",
      class = "btn-primary",
      # The value of js_class determines whether the class is applied
      condition = "primary" %in% input$js_class
    )
    
    shinyjs::toggleClass(
      id = "js_button_style",
      class = "btn-lg",
      # The value of js_class determines whether the class is applied
      condition = "large" %in% input$js_class
    )
  })
  
  
  # Run some arbitrary JavaScript code -----------------------------------------
  
  observe({
    shinyjs::runjs("var today = new Date(); alert(today);")
  }) |>
    bindEvent(input$js_message)
  
}

shinyApp(ui, server)
