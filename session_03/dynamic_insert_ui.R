library(shiny)

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

# Create a list group for button layout
# https://getbootstrap.com/docs/5.2/components/list-group/
listGroup <- function(..., class = "") {
  div(class = paste("list-group", class), ...)
}

listGroupAction <- function(id, label, class = "", ...) {
  actionLink(id, label, class = paste("list-group-item list-group-item-action", class), ...)
}

ui <- fixedPage(
  theme = bslib::bs_theme(version = 5),
  titlePanel("Dynamic UI with insertUI() and removeUI()"),
  tabsetPanel(
    
    tabPanel(
      "Text box",
      fixedRow(
        class = "m-4",
        column(3,
          listGroup(
            listGroupAction("add", "Add text box"),
            listGroupAction("clear_div_first", "Delete first by selector"),
            listGroupAction("clear_div_all", "Delete all by selector"),
            listGroupAction("clear_id_first", "Delete first by ID"),
            listGroupAction("clear_id_last", "Delete last by ID"),
            listGroupAction("clear_id_all", "Delete all by ID")
          )
        ),
        # Empty div to be used in selectors
        column(9, div(id = "text_div"))
      ),
    ),
    
    tabPanel(
      "Alerts",
      fixedRow(
        class = "m-4",
        column(12, actionButton("alert_me", "Alert me!"))
      ),
      fixedRow(
        class = "m-4",
        # Empty div to be used in selectors
        column(12, div(id = "alert_div"))
      )
    )
  )
)

server <- function(input, output, session) {
  # See [jQuery selectors](https://api.jquery.com/category/selectors/) and
  # [CSS selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
  # for details of select
  
  txt_insert <- c()
  
  # Add a text box -------------------------------------------------------------
  
  # Add a new text box to the text_div when add is clicked
  observe({
    id <- paste0("txt", input$add)
    insertUI(
      selector = "#text_div",
      where = "beforeEnd",
      ui = textInput(id, paste("Text box:", id))
    )
    txt_insert <<- c(txt_insert, id)
  }) |>
    bindEvent(input$add)
 
  # Remove text box using generic selector -------------------------------------
  
  # This selector selects div tags that are children of the text_div.
  # By default, removeUI() will only remove the first element that meets the
  # criteria
  observe({
    removeUI(selector = "#text_div > div")
    txt_insert <<- txt_insert[-1]
  }) |>
    bindEvent(input$clear_div_first)
  
  # We can remove all at once using the multiple argument
  observe({
    removeUI(selector = "#text_div > div", multiple = TRUE)
    txt_insert <<- c()
  }) |>
    bindEvent(input$clear_div_all)
   
  
  # Remove text box by ID ------------------------------------------------------
  
  # We store the ID of each text box in the `txt_insert` vector,
  # which we can use to remove the first or last box added. 
  
  # Note we need to use a more complicated selector, since there is a div around
  # the text box and label. The selector used below selects divs that contain an
  # element with the ID "txt{i}"
  
  observe({
    removeUI(selector = paste0("div:has(> #", txt_insert[1], ")"))
    txt_insert <<- txt_insert[-1]
  }) |>
    bindEvent(input$clear_id_first)
  
  observe({
    removeUI(selector = paste0("div:has(> #", txt_insert[length(txt_insert)], ")"))
    txt_insert <<- txt_insert[-length(txt_insert)]
  }) |>
    bindEvent(input$clear_id_last)
  
  observe({
    for (id in rev(txt_insert)) {
      Sys.sleep(0.5)
      removeUI(selector = paste0("div:has(> #", id, ")"), immediate = TRUE)
    }
    txt_insert <<- c()
  }) |>
    bindEvent(input$clear_id_all)
  
  # Alert ----------------------------------------------------------------------
  
  # Add an alert to the alert_div when alert_me is clicked
  observe({
    insertUI(
      selector = "#alert_div",
      where = "beforeEnd",
      ui = alert(paste0("Alert at ", Sys.time()), class = "alert-primary")
    )
  }) |>
    bindEvent(input$alert_me)
}

# Complete app with UI and server components
shinyApp(ui, server)
