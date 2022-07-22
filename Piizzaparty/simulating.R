# Libraries ----

library(shiny)
library(shinyjs)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)

# ui <- dashboardPage(
#   header = header,
#   sidebar = sidebar,
#   title = "Simulate",
#   skin = "purple", # "blue", "black", "purple", "green", "red", "yellow"
#   body = dashboardBody(
#     useShinyjs(),
#     tags$head(
#       tags$link(rel = "stylesheet",
#                 type = "text/css",
#                 href = "custom.css")
#     ),
#     tabItems(
#       main_tab,
#       norm_tab,
#       binom_tab,
#       pois_tab,
#       unif_tab
#     )
#   )
# )

##func.R
plot_unif <- function(df) {
  if (is.null(df)) return(ggplot() + theme_bw())

  if (length(unique(df$n)) == 1 && unique(df$n) == 1) {
    # all N are 1
    df1 <- df %>%
      group_by(min, max) %>%
      mutate(Sample = paste0("runif(", n(), ", ", min, ", ", max, ")")) %>%
      ungroup()

    #ylim(min(df1$min)-0.5, max(df1$max)+0.5) +
  } else {
    df1 <- df %>%
      mutate(Sample = paste0(LETTERS[sample - min(sample) + 1],
                             ": runif(", n, ", ", min, ", ", max, ")"))
  }

  ncolumns <- ceiling(length(unique(df1$Sample))/5)

  p <- ggplot(df1, aes(x, fill = Sample))

  # make each facet as a separate layer to get bins and boundaries correct
  for (s in unique(df1$Sample)) {
    dat <- filter(df1, Sample == s)
    bd <-  min(dat$min)
    bw <- (max(dat$max) - bd)/20
    p <- p + geom_histogram(data = dat, boundary = bd,
                            binwidth = bw, color = "black", alpha = 0.2,
                            position = position_dodge(), show.legend = FALSE)
  }

  p + facet_wrap(~Sample, ncol = ncolumns, dir = "v", scales = "free_y") +
    theme_bw()
}

####ui
ui <- unif_tab
unif_tab <- tabItem(
  tabName = "unif_tab",
  p("The uniform distribution is the simplest distribution. All numbers in the range have an equal probability of being sampled. P-values have a uniform distribution under the null hypothesis (i.e., when there is no effect, all numbers between 0 and 1 are equally probable)."),
  #box(title = "Tasks", width = 12,
  tags$ul(
    tags$li("Set n = 1000, min = 0, and max = 1. Plot data by clicking the 'Sample Again' button. Do this 5 times. How much does the distribution change between samples?"),
    tags$li("Clear the samples and plot 5 sets of data with n = 10. Does the distribution change more or less?"),
    tags$li("Set n = 100 and min = 0. Plot data with max of 1, 10, 100, and 1000"),
    tags$li("Clear the samples and set n = 1, min = 0, and max = 1. Now each sample adds to the overall distribution. How many times do you need to sample to get a value < 0.05 (i.e., in the first bin)?")
  ),
  #    collapsible = TRUE, collapsed = TRUE),
  div(class="func-spec",
      span("runif(n = "),
      numericInput("unif_n", NULL, 100, 1, 1000, 1),
      span(", min = "),
      numericInput("unif_min", NULL, 0, NA, NA, 1),
      span(", max = "),
      numericInput("unif_max", NULL, 1, NA, NA, 1),
      span(")")
  ),
  actionButton("unif_sample", "Sample Again"),
  actionButton("unif_clear", "Clear Samples"),
  plotOutput("unif_plot", height = "500px")
)


#######app.R
server <- function(input, output, session) {
unif_df <- reactiveVal()

# create uniform sample ----
observeEvent(input$unif_sample, {
  n <- isolate(input$unif_n) %>% as.integer()
  min <- isolate(input$unif_min) %>% as.double()
  max <- isolate(input$unif_max) %>% as.double()

  if (is.na(n) || n < 1) {
    showNotification("The n was not valid; it must be >= 1")
    n <- 1
    updateNumericInput(session, "unif_n", value = n)
  }
  if (is.na(min) || min >= max) {
    showNotification("The min was not valid; it must be < max")
    min <- 0
    updateNumericInput(session, "unif_min", value = min)
  }
  if (is.na(max) || max <= min) {
    showNotification("The max was not valid; it must be > min")
    max <- 1
    updateNumericInput(session, "unif_max", value = max)
  }

  new_df <- data.frame(
    sample = as.integer(input$unif_sample),
    n = n,
    min = min,
    max = max,
    x = runif(n, min, max)
  )

  if (!is.null(unif_df())) {
    new_df <- bind_rows(unif_df(), new_df)
  }

  unif_df(new_df)
}, ignoreNULL = TRUE)

observeEvent(input$unif_clear, {
  unif_df(NULL)
})

# unif_plot ----
output$unif_plot <- renderPlot({
  plot_unif(unif_df())
})

}
shinyApp(ui = ui, server = server)




a <- 1
b <- 2
ggplot(placeorder,aes())

