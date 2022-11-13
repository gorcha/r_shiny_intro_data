library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  titlePanel("Dynamic visibility"),
  tabsetPanel(
    
    tabPanel(
      "tabsetPanel()",
      class = "pt-2",
      sidebarLayout(
        fluid = FALSE,
        sidebarPanel(
          radioButtons("tab_select", "Select content", 1:3, 1)
        ),
        mainPanel(
          # Note that that the tabsetPanel() has type = "hidden" - tab titles
          # will not display and the user can not change tabs in the usual way
          tabsetPanel(
            id = "tab_set",
            type = "hidden",
            tabPanelBody("panel1", "Panel 1 content"),
            tabPanelBody("panel2", "Panel 2 content"),
            tabPanelBody("panel3", "Panel 3 content")
          )
        )
      )
    ),
    
    tabPanel(
      "conditionalPanel()",
      fixedRow(
        class = "border pt-2",
        column(6,
          checkboxInput("show_panel", "Show panel?"),
        ),
        column(6,
          # We can reference input elements directly in JavaScript, bypassing
          # the server function
          # Note that the condition is a JavaScript expression
          conditionalPanel(
            "input.show_panel == true",
            "My panel!"
          )
        )
      ),
      fixedRow(
        class = "border pt-2",
        # For more complex expressions it's easier to use a reactive value
        # created in the server function
        column(6,
          checkboxGroupInput("checks", "Check some boxes...", choices = 1:10),
        ),
        column(6,
          conditionalPanel(
            "output.show_complex_panel == true",
            "The number of selected checkboxes is a multiple of 3!"
          )
        )
      )
    )
  )
)
    
server <- function(input, output, session) {
  # Change the visible tab based on tab_select
  observe({
    updateTabsetPanel(
      session,
      "tab_set",
      selected = paste0("panel", input$tab_select)
    )
  })
  
  # Create an invisible output for reference in the conditional panel expression
  output$show_complex_panel <- reactive({
    length(input$checks) %% 3 == 0 & length(input$checks) != 0
  })
  
  # Tell Shiny that this output should be updated even though it's not visible
  # By default hidden elements are not updated to minimise unnecessary
  # processing
  outputOptions(output, "show_complex_panel", suspendWhenHidden = FALSE)
}

shinyApp(ui, server)
