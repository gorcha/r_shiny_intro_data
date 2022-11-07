library(shiny)

ui <- fluidPage(
  titlePanel("Fluid Page"),
  
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
      h3("Content!")
    )
  )
)

runApp(list(ui = ui, server = function(input, output, session) { }))


ui <- fixedPage(
  titlePanel("Fixed Page"),
  
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
      h3("Content!")
    )
  )
)

runApp(list(ui = ui, server = function(input, output, session) { }))


ui <- fillPage(
  titlePanel("Fill Page"),
  
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
      h3("Content!")
    )
  )
)

runApp(list(ui = ui, server = function(input, output, session) { }))

