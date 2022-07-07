library(shiny)

shinyApp(
  ui = fluidPage(responsive = FALSE
                 ,fluidRow(style = "padding-bottom: 20px;"
                           ,column(width=6,
                                   textOutput("clickCount")
                           )
                           ,column(width=6,
                                   actionButton("button", "Click"),
                                   tags$button(
                                     id = "my_button",
                                     class = "btn action_button",
                                     tags$img(src = ",height = "50px") #internet image
                                     #tags$img(src = "your_image.png",height = "50px") #local image
                                   ),
                           )
                 )
  )
  ,server = function(input, output, session) {
    output$clickCount <- renderText({
      input$button
    })
  }
  ,options = list(height = 500)
)

