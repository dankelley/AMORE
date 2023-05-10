library(shiny)
library(oce)

files <- list.files(path="~/data/arctic/beaufort/2012", pattern=".cnv$", full.names=TRUE)

ui <- fluidPage(
    fluidRow(column(12, selectInput("file", "CNV File:", files, width="100%"))),
    fluidRow(column(12, uiOutput("plotPanel"))))

server <- function(input, output)
{
    output$plotPanel <- renderUI({
        plotOutput("plot", height=600)
    })

    output$plot <- renderPlot({
        input$file |> read.oce() |> plot()
    }, pointsize=20)
}

shinyApp(ui, server)
