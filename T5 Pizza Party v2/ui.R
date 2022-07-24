library(shiny)



ui <- fluidPage(
  
    titlePanel(title=div(img(src="logo.jpg", height = 70), "Pizza Party - Team Ninja"), windowTitle = "Pizza Party"),  
    
    fluidRow(
      
      column(3,
             wellPanel(
               
               h4("Factory"),
               sliderInput(
                 inputId = "tomato_bought",
                 label = "Tomato",
                 min = 0,
                 max = 100,
                 value = 0,
                 step = 1
               ),
               actionButton(inputId = "purchase",
                            label = "Purchase Ingredients", class="btn btn-success action-button")
             ),
             wellPanel(
               
               h4("Shop 1"),
               sliderInput(
                 inputId = "vpizza_made",
                 label = "Veggie Delight",
                 min = 0,
                 max = 100,
                 value = 0,
                 step = 1
               ),
               actionButton(inputId = "s1_pizza",
                            label = "Pizza to sell", class="btn btn-success action-button")
              
             ),
    wellPanel(
    
    h4("Service 1"),
    
    sliderInput(
      inputId = "s1_fare_increase",
      label = "Set fare change (%)",
      min = -100,
      max = 100,
      value = 0,
      step = 1
    ),
    sliderInput(
      inputId = "s1_mileage_increase",
      label = "Set mileage change (%)",
      min = -100,
      max = 100,
      value = 0,
      step = 1
    )
    ),
    wellPanel(
      h4("Service 2"),
      
      sliderInput(
        inputId = "s2_fare_increase",
        label = "Set fare change (%)",
        min = -100,
        max = 100,
        value = 0,
        step = 1
      ),
      sliderInput(
        inputId = "s2_mileage_increase",
        label = "Set mileage change (%)",
        min = -100,
        max = 100,
        value = 0,
        step = 1
    )
    ),
    # wellPanel(
    #   actionButton(inputId = "purchase",
    #                label = "Purchase Ingredients", class="btn btn-success action-button")
    # ),
    # wellPanel(
    #   actionButton(inputId = "s1_pizza",
    #                label = "Pizza to sell", class="btn btn-success action-button")
    # ),
    wellPanel(
    conditionalPanel(
      condition = "output.bankrupt == 'no' & output.year != '25'",
    actionButton(inputId = "simulate",
                 label = "Simulate next year", class="btn btn-success action-button")),
    
      conditionalPanel(
        condition = "output.bankrupt == 'yes' || output.year == '25'",
        actionButton(inputId = "simulate",
                     label = "Simulate next year", class="btn btn-success action-button disabled")
    
  
    ),
    
    tags$br(),
    tags$button("Restart", id="restart", type="button", class="btn btn-danger action-button", onclick="history.go(0)")
    )
    ),
    
    # beginning of right side
    
    
    column(9,
           
    
           fluidRow(
             column(2, 
                    h4("Year")
             ),
             column(2,
                    h4("Gross profit")
             ),
             column(2,
                    h4("Tax paid")
             ),
             column(2, 
                    h4("Net profit")
             ),
             column(2, 
                    h4("Interest due")
             ),
             column(2, 
                    h4("Balance")
             )
           ),
           
    
    fluidRow(
      column(2, 
             wellPanel (
               div(textOutput("year"),style = "font-size:125%")
             )
             ),
      column(2,
             
             wellPanel (
               div(textOutput("grossprofit"),style = "font-size:125%")
               )
             
      ),
      column(2,
             
             wellPanel (
               div(textOutput("taxpaid"),style = "font-size:125%")
               )
             
      ), 
      column(2,
             
             wellPanel (
               div(textOutput("netprofit"),style = "font-size:125%")
               )
             
      ),     
            
      column(2, 
             wellPanel(
               div(textOutput("interestdue"),style = "font-size:125%")
               )
             ),
      column(2, 
             wellPanel(
               div(textOutput("balance"),style = "font-size:125%")
               )
             )
    ),
    
    
    fluidRow(
      column(12, 
             
             wellPanel(style = "color:red", textOutput("feedback"))
             
      )
    ),
    
    fluidRow(
      column(12,
      
      tabsetPanel(
        
        
        tabPanel("Instructions", 
                 includeHTML("include.html")),
        
        
      tabPanel("Company", 
               h5("Summary financial data for the Domino Bus Group"),
               downloadButton('downloadData', 'Download Data', class="btn-xs btn-info"),
               div(tableOutput("c_data_out"), style = "font-size:80%")
               ),
      tabPanel("Factory", 
               h5("Summary financial data for the Domino Bus Group"),
               # downloadButton('downloadData', 'Download Data', class="btn-xs btn-info"),
               div(tableOutput("f_data_out"), style = "font-size:80%")
      ),
      tabPanel("Shop 1", 
               h5("Summary financial data for the Domino Bus Group"),
               # downloadButton('downloadData', 'Download Data', class="btn-xs btn-info"),
               div(tableOutput("s1_data_out"), style = "font-size:80%")
      ),
      
      tabPanel("Graphs",
               fluidRow(
                 column(4, 
                        plotOutput("passengers", height = 300)
                 ),
                 column(4,
                        plotOutput("miles", height = 300)
                 ),
                 column(4,
                        plotOutput("revenue", height = 300)
                 )),
               fluidRow(
                 column(4,
                        plotOutput("costs", height = 300)
                 ),
                 column(4,
                        plotOutput("profit", height = 300)
                 ),
                 column(4,
                        plotOutput("cbalance", height = 300)
                 )
               )
               
      ),
      
      tabPanel("About", 
               includeHTML("about.html"))
      
      )
    ))
    
 
    ) #column end
    
)
)