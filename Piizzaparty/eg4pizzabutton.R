library(shiny)
spizza <- img(src="Shroom.png")
vpizza <- img(src="Veggie.png")
cpizza <- img(src="Chicken.png")
bpizza <- img(src="Bacon.png")
shinyApp(
  ui = fluidPage(responsive = FALSE,

                 fluidRow(style = "padding-bottom: 20px;"
                           ,column(width=6,
                                   textOutput("clickCount1")
                           )
                           ,column(width=6,
                                   actionButton("button1", spizza ,style='height:170px'),


                           )

                 )
                 ,fluidRow(style = "padding-bottom: 20px;"
                           ,column(width=6,
                                   textOutput("clickCount2")
                           )
                           ,column(width=6,
                                   actionButton("button2", vpizza ,style='height:170px'),


                           )

                 )
                 ,fluidRow(style = "padding-bottom: 20px;"
                           ,column(width=6,
                                   textOutput("clickCount3")
                           )
                           ,column(width=6,
                                   actionButton("button3", cpizza ,style='height:170px'),


                           )

                 )
                 ,fluidRow(style = "padding-bottom: 20px;"
                           ,column(width=6,
                                   textOutput("clickCount4")
                           )
                           ,column(width=6,
                                   actionButton("button4", bpizza ,style='height:170px'),


                           )

                 )

  )
  ,server = function(input, output, session) {
    # decrease <- reactive({
    #   if(input$decrease ==0)return ()
    # var <- var-1
    output$clickCount1 <- renderText({
      input$button1
    })
    output$clickCount2 <- renderText({
      input$button2
    })
    output$clickCount3 <- renderText({
      input$button3
    })

    output$clickCount4 <- renderText({
      input$button4
    })


  }
  ,options = list(height = 500)
)



