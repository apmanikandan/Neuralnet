setwd("/Users/manikandanap/Desktop/R Scripts/")

script_list <- list("Init.R","PredictRate.R")

for (loop_variable in 1:length(script_list)){
        try(source(script_list[[loop_variable]]))
}


library(shiny)
library (tseries)
library (xts)
library (zoo)
library (quantmod)

ui <- fluidPage(
        titlePanel(title = "Close Rate Prediction"),
        
        sidebarLayout(
                sidebarPanel( helpText("Stock information will be gathered using yahoo finance."),
                              
                              
                              dateRangeInput("dates", 
                                             "Date range",
                                             start = "2010-01-01", 
                                             end = as.character(Sys.Date())),
                              
                              br(),
                              br(),
                              
                              actionButton(inputId = "go",
                                           label = "PredictClosingRate")
                ),
                mainPanel(
                        plotOutput("plot"),
                        verbatimTextOutput(outputId = "text_form")
                )
                
        )
)



server <- function(input, output){
        
        output$plot <- renderPlot({
                data <- getSymbols(symbol, src = "yahoo", 
                                   from = input$dates[1],
                                   to = input$dates[2],
                                   auto.assign = FALSE)
                
                chartSeries(data, theme = chartTheme("white"), 
                            type = "candlesticks", TA = NULL,major.ticks='auto', minor.ticks=TRUE)
        })
        
        data1 <- eventReactive(input$go, Close_rate)
        output$text_form <- renderText({paste("The Closing Rate for ",Sys.Date(),"might be around: ",data1())})
}

shinyApp(ui = ui, server = server)
