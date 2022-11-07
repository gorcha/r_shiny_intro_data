# Example from https://rstudio.github.io/thematic/
library(shiny)
library(ggplot2)
library(thematic)

# Call thematic_shiny() prior to launching the app, to change 
# R plot theming defaults for all the plots generated in the app
thematic_shiny(font = "auto")

ui <- fluidPage(
  # bslib makes it easy to customize CSS styles for things 
  # rendered by the browser, like tabsetPanel()
  # https://rstudio.github.io/bslib
  theme = bslib::bs_theme(
    bg = "#002B36", fg = "#EEE8D5", primary = "#2AA198",
    # bslib also makes it easy to import CSS fonts
    base_font = bslib::font_google("Pacifico")
  ),
  tabsetPanel(
    type = "pills",
    tabPanel("ggplot", plotOutput("ggplot")),
    tabPanel("lattice", plotOutput("lattice")),
    tabPanel("base", plotOutput("base"))
  )
)

server <- function(input, output) {
  output$ggplot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars), color = factor(cyl))) +
      geom_point() +
      ggrepel::geom_text_repel()
  })
  output$lattice <- renderPlot({
    lattice::show.settings()
  })
  output$base <- renderPlot({
    image(volcano, col = thematic_get_option("sequential"))
  })
}

shinyApp(ui, server)
