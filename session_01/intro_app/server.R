mpg_data <- mtcars
mpg_data$am <- factor(mpg_data$am, labels = c("Automatic", "Manual"))

server <- function(input, output, session) {
  formula_text <- reactive({
    paste("mpg ~", input$variable)
  })
  
  output$caption <- renderText({
    formula_text()
  })
  
  output$mpg_plot <- renderPlot({
    boxplot(
      as.formula(formula_text()),
      data = mpg_data,
      outline = input$outliers,
      col = "#75AADB",
      pch = 19
    )
  })
}
