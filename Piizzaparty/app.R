#install.packages("shinythemes")
# install.packages("shinyWidgets")

## ui.R ##
library(shiny)
library(bslib)
library(shinythemes)
library(tidyverse)
library(shinyjqui)
library(ggplot2)
library(highcharter)
library(shinyWidgets)
test1 <- fluidPage(setBackgroundImage(src='Homepage.png'))
shinyApp(

  ui = navbarPage("PlayerName",
                  theme = shinythemes::shinytheme("united"),  # <--- Specify theme here
                  tabPanel("Game Page", test1 ),
                  tabPanel("Main Page"),
                  navbarMenu("More",
                             tabPanel("Summary", "Summary tab contents..."),
                             tabPanel("Table", "Table tab contents...")

                  ),


  ),



  server = function(input, output) { }


)

