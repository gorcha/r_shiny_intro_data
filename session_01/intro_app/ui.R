ui <- fluidPage(
  titlePanel("Miles Per Gallon"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "variable",
        "Variable:", 
        c("Cylinders" = "cyl", "Transmission" = "am", "Gears" = "gear")
      ),
      p("Simple text with a ", a("hyperlink", href = "#")),
      
      checkboxInput("outliers", "Show outliers", TRUE)
    ),
    
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("mpg_plot")
    )
  )
)
