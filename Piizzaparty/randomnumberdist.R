



###############Database##################
# At the beginning of any R session, record your AWS database password:
# source("setAWSPassword.R")
#
# # Now, anywhere in your code where the password is needed you can get it using
# #getOption("AWSPassword")
# # Otherwise it is hidden. So now this code can be shared with anyone
# # without giving them access to your personal AWS database.
#
# source("usePackages(1).R")
# loadPkgs(c("tidyverse","shiny","DBI"))
#
# #References
# #https://shiny.rstudio.com/reference/shiny/latest/modalDialog.html
# #https://shiny.rstudio.com/reference/shiny/0.14/passwordInput.html
# #https://shiny.rstudio.com/articles/sql-injections.html
# #https://shiny.rstudio.com/reference/shiny/0.14/renderUI.html
#
#
# #Generate, or re-generate, HTML to create modal dialog for Password creation
#
#
#
# getAWSConnection <- function(){
#   conn <- dbConnect(
#     drv = RMySQL::MySQL(),
#     dbname = "student016",
#     host = "esddbinstance-1.ceo4ehzjeeg0.ap-southeast-1.rds.amazonaws.com",
#     port = 3306,
#     username = "student016",
#     password = getOption("AWSPassword"))
#   conn
# }
#
#
#
#
# get <- function(){
#   #open the connection
#   conn <- getAWSConnection()
#   gamevariants <- dbGetQuery(conn,"SELECT * FROM LeaderGameVariant")
#   variantids <- gamevariants$gamevariantid # a vector
#   variantnames <- gamevariants$variantname # a vector
#   names(variantids) <- variantnames
#   #Close the connection
#   dbDisconnect(conn)
#   variantids
# }
#
# publishScore <- function(playerid,gamevariantid,score){
#   conn <- getAWSConnection()
#   querytemplate <- "INSERT INTO PizzaDemand (day, chickenpizza, vegpizza,baconpizza, shroompizza) VALUES (?id1,?id2,NOW(),?id3)"
#   query <- sqlInterpolate(conn, querytemplate,id1=playerid,id2=gamevariantid,id3=score)
#   #print(query) #for debug
#   success <- FALSE
#   tryCatch(
#     {  # This is not a SELECT query so we use dbExecute
#       result <- dbExecute(conn,query)
#       print("Score published")
#       success <- TRUE
#     }, error=function(cond){print("publishScore: ERROR")
#       print(cond)
#     },
#     warning=function(cond){print("publishScore: WARNING")
#       print(cond)},
#     finally = {}
#   )
#   dbDisconnect(conn)
# }
#
# ui <- fluidPage(
#   actionButton("nextday", "Next Day"),
#   # actionButton("login", "Login"),
#   # htmlOutput("loggedInAs"),
#   # selectInput("gamevariantid", "Select the Game Variant to Play:",
#   #             getGameVariantList()),
#   # actionButton("playgame", "Play the Game"),
#   # htmlOutput("score"),
#   # uiOutput("moreControls")
# )
#
#
# server <- function(input, output, session) {
#   # reactiveValues object for storing items like the user password
#   vals <- reactiveValues(chickenpizza=NULL,vegpizza=NULL,baconpizza=NULL,shroompizza=NULL)
#
#
#   observeEvent(input$nextday, {
#
#     ## Uniform~(10,15) shroom pizza
#     vals$shroompizza=as.integer(runif(1, min=10, max=15))
#
#     ## Uniform ~(15,20) chicken pizza
#     vals$chickenpizza=runif(1, min=15, max=20)
#
#     ## Normal~(mu = 10, stddev= 2) Bacon Party
#     vals$baconpizza=rnorm(1, mean = 10, sd=2)
#
#     ## Normal~(mu = 8, stddev= 3) Veggie Delights
#     vals$vegpizza=rnorm(1, mean = 8, sd=3)
#
#     print(vals$shroompizza,vals$chickenpizza,vals$baconpizza,vals$vegpizza)
#   })
#
#   # React to completion of game
#   output$nextday <- renderUI({
#
#     as.character(vals$shroompizza)
#     as.character(vals$chickenpizza)
#     as.character(vals$baconpizza)
#     as.character(vals$vegpizza)
#   })
#
#
#   output$moreControls <- renderUI({
#
#     tagList(
#       actionButton("nextday", "Next Day")
#     )
#   })
#   observeEvent(input$nextday,{
#     publishScore(vals$shroompizza,vals$vegpizza,vals$chickenpizza, vals$baconpizza)
#   })
#
# }
#
# shinyApp(ui, server)

######################end of database######################


# ###generate random number of pizzas with different distribution
# #?distribution
#
# ## Uniform~(10,15) shroom pizza
# runif(1, min=10, max=15)
#
# ## Uniform ~(15,20) chicken pizza
# runif(1, min=15, max=20)
#
# ## Normal~(mu = 10, stddev= 2) Bacon Party
# rnorm(1, mean = 10, sd=2)
#
# ## Normal~(mu = 8, stddev= 3) Veggie Delights
# rnorm(1, mean = 8, sd=3)
####################################


####"next day"" button generates random number with specific distribution###
library(shiny)

shinyApp(
  ui = fluidPage(responsive = FALSE,

                 fluidRow(style = "padding-bottom: 20px;"
                          ,column(width=6,
                                  textOutput("clickCount1")
                          )
                          ,column(width=6,
                                  actionButton("nextday", "Next Day" ,style='height:170px'),

                          )

                 )


                 )

  ,server = function(input, output, session) {
    # Use an action button as an event to generate the list of random numbers
    random_data <- eventReactive(input$nextday, {

      # Randomly sample values from the specified range
      numbers <- seq(input$rangeStart:input$rangeEnd)
      sample(numbers, input$values, replace = as.logical(input$dupes))

    })

    # Output the list of random numbers only AFTER the "Generate!" button is pressed
    output$randNumbers <- renderTable({
      random_data()
    }, rownames = FALSE, colnames = FALSE)
  }

)
    # output$clickCount1 <- renderText({
    #   input$button1
    # })



#   }
#   ,options = list(height = 500)
# )




