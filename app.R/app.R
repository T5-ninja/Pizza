#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
# hi
#    http://shiny.rstudio.com/
#
install.packages("shinythemes")

## ui.R ##
library(shiny)
library(bslib)
library(shinythemes)

shinyApp(
  ui = navbarPage("United",
                  theme = shinythemes::shinytheme("united"),
                  tabPanel("Plot", "Plot tab contents..."),
                  navbarMenu("More",
                             tabPanel("Summary", "Summary tab contents..."),
                             tabPanel("Table", "Table tab contents...")
                  )
  ),
)
# server = function(input, output)
# {

# }
