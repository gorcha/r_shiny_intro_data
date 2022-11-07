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

# Create dismissable alerts. See the HTML example in the Bootstrap docs:
# https://getbootstrap.com/docs/5.2/components/alerts/#dismissing
alert <- function(..., class = "") {
  div(
    class = paste("alert alert-dismissible fade show", class),
    role = "alert",
    ...,
    tags$button(
      type = "button",
      class = "btn-close",
      `data-bs-dismiss` = "alert",
      `aria-label` = "Close"
    )
  )
}

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  # Typography and text utility classes
  # https://getbootstrap.com/docs/5.2/content/typography/
  # https://getbootstrap.com/docs/5.2/utilities/text/
  h1(class = "display-3 text-center", "Bootstrap styling"),
  p(class = "lead text-center", "Some stylish examples"),
  p(
    textOutput("button_clicks"),
  ),
  p(
    # A plain action button with default styling
    actionButton("plain_button", "Button"),
    # Buttons using semantic styling
    actionButton("primary_button", "Primary", class = "btn-primary"),
    actionButton("success_button", "Success!", class = "btn-success")
  ),
  p(
    # Create a button group, adding additional styling
    buttonGroup(
      class = "btn-group-lg",
      actionButton("yes_button", "Yes", class = "btn-success"),
      actionButton("maybe_button", "Maybe", class = "btn-warning"),
      actionButton("no_button", "No", class = "btn-danger")
    )
  ),
  # Create an alert. The `alert-warning` class provides styling
  alert(class = "alert-warning", "Something needs your attention!")
)

server <- function(input, output, session) {
  # The action button input returns the number of times it has been pressed, so 
  # can count the total number of clicks by adding the buttons together
  click_count <- reactive({
    input$plain_button +
      input$primary_button +
      input$success_button +
      input$yes_button +
      input$maybe_button +
      input$no_button
  })
  
  output$button_clicks <- renderText({
    paste(
      "Total button clicks:", click_count()
    )
  })
}

shinyApp(ui, server)
