library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  titlePanel("Dynamic UI with renderUI()"),
  tabsetPanel(
    
    tabPanel(
      "Basic",
      fixedRow(
        class = "m-4",
        column(12, checkboxInput("render_ui", "Render UI?"))
      ),
      uiOutput("custom_ui")
    ),
    
    tabPanel(
      "Lists",
      fixedRow(
        class = "m-4",
        column(12,
          selectInput(
            "item_list",
            "Select items to render",
            1:10,
            # Allow multiple selections
            multiple = TRUE
          )
        )
      ),
      uiOutput("list_ui")
    )
  )
)

server <- function(input, output, session) {
  # Only render UI if certain conditions are met
  output$custom_ui <- renderUI({
    if (input$render_ui) {
      # Use tagList() to group a block of UI elements
      tagList(
        selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
        tableOutput("table")
      )
    } else {
      NULL
    }
  })
  
  # Dynamically created elements with static names are used the same way as
  # statically created elements
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
  
  # Create UI elements based on the options selected in item_list
  # Use lapply() to create multiple similar UI elements at once
  output$list_ui <- renderUI({
    lapply(input$item_list, function(x) {
      fixedRow(
        class = "border pt-2 mt-2",
        column(3,
          textInput(
            inputId = paste0("item_lbl_", x),
            label = "Button label",
            value = paste0("Button for item ", x)
          )
        ),
        column(3,
          actionButton(paste0("item_btn_", x), "")
        ),
        column(6,
          textOutput(paste0("item_txt_", x))
        )
      )
    })
  })
  
  # Use observe() to render output with dynamically created output IDs
  observe({
    lapply(input$item_list, function(x) {
      output[[paste0("item_txt_", x)]] <- renderText({
        paste0("The button label is: ", input[[paste0("item_lbl_", x)]])
      })
    })
  })

  observe({
    lapply(input$item_list, function(x) {
      updateTextInput(
        session,
        inputId = paste0("item_btn_", x),
        label = input[[paste0("item_lbl_", x)]]
      )
    })
  })
}

shinyApp(ui, server)
