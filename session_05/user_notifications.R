library(shiny)

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  
  headerPanel("Notifications"),
  
  textInput("message", "Notification message", value = "My message"),
  numericInput("duration", "Duration", value = 5),
  radioButtons("type", "Notification type", c("default", "message", "warning", "error")),
  checkboxInput("action", "Include action", value = TRUE),
  checkboxInput("close_button", "Close button", value = TRUE),
  checkboxInput("assign_id", "Assign ID", value = FALSE),
  
  actionButton("notify", "Notify"),
  actionButton("remove", "Remove")
)

server <- function(input, output, session) {
  observe({
    # Optional action UI can be provided
    if (input$action) {
      action <- a(href = "javascript:location.reload();", "Reload page")
    } else {
      action <- NULL
    }
    
    # NULL duration leaves the notification up until it's clsoed with the close
    # button or removeNotification().
    # If duration is 0 or lower we will use NULL
    if (input$duration > 0) {
      duration <- input$duration
    } else {
      duration <- NULL
    }
    
    # If an ID is assigned the notification will overwrite an existing
    # notification with the same ID.
    # Assigning an ID allows us to use the removeNotification() function
    if (input$assign_id) {
      id <- "notification"
    } else {
      id <- NULL
    }
    
    # Display the notification with the selected options
    showNotification(
      input$message,
      action = action,
      duration = duration,
      closeButton = input$close_button,
      id = id,
      type = input$type
    )
  }) |>
    bindEvent(input$notify)
  
  # Remove a notification. Only works if an ID has been assigned.
  observe({
    removeNotification("notification")
  }) |>
    bindEvent(input$remove)
}

shinyApp(ui, server)
