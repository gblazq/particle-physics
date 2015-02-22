# server.R
library(shiny)
library(ggplot2)

model <- function(x, mean, f){
    m*binLength*(f*dnorm(x, mean, sd) + 
                     (1-f)*rate/(exp(-min*rate)-exp(-max*rate))*exp(-x*rate))
}

sd <- 100
rate <- 1/1000

massData <- read.table("data.dat", col.names = c("mass"))
m <- length(massData[[1]])
min <- min(massData)
max <- max(massData)
hist <- hist(massData$mass, breaks = 30, plot=FALSE)
binLength <<- hist$breaks[2]-hist$breaks[1]

shinyServer(function(input, output){
    data <- reactive({
        data.frame(breaks = hist$breaks[-length(hist$breaks)] + binLength/2, 
                   counts = hist$counts, 
                   sd = as.numeric(input$sigmas)*sqrt(hist$counts))
    })
    chisquared <- reactive({
        normHist <- data()
        sum((normHist$counts - 
                 model(normHist$breaks, input$mean, input$f))^2/normHist$counts)
    })
    # Create the plot (histogram + error bars + model)
    output$plot <- renderPlot({
        normHist <- data()
        plot <- ggplot(normHist, aes(x = breaks, y = counts)) + 
            geom_bar(stat="identity", fill="tomato") + 
            geom_errorbar(aes(ymax = counts + sd, ymin = counts - sd), 
                          width = binLength/2) + 
            stat_function(fun = model, args=list(input$mean, input$f)) +
            coord_cartesian(ylim=c(0, 2000)) + 
            ggtitle("Histogram\n") + xlab("Mass (MeV/c^2)") + ylab("Counts") +
            theme(plot.title = element_text(face="bold", size = 20))
        if(input$chisquared == TRUE){
            plot <- plot + annotate("text", x = 6100, y = 1500, 
                                    label = paste("chi^2 == ", chisquared()), 
                                    parse=TRUE, size=9)
        }
        plot
    })
})
