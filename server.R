# Text of the articles was downloaded from: https://triz-journal.com/
#
# There're 3 sets of articles for the chosen periods of time.
# The articles from every set were merged into three text files respectively. 
#
# Example of code for merging articles:
# dest <- "D:/Coursera/DevelopingDataProd/CourseProject/App/data/new"
# myfiles <- list.files(path = dest, pattern = "txt")
# outFile <- file("new.txt", "w") 
# for (i in myfiles){ 
#     x <- readLines(i) 
#     writeLines(x[2:(length(x)-1)], outFile) 
# } 
# close(outFile)
#
# Three resulting files were packed for further processing.

library(shiny)
library(rmarkdown)

source("global.R")

function(input, output, session) {
        terms <- reactive({
        input$update
        isolate({
            withProgress({
                setProgress(message = "Please wait, processing corpus...")
                getTermMatrix(input$selection)
            })
        })
    })
    
    wordcloud_rep <- repeatable(wordcloud)
    
    output$plot <- renderPlot({
        v <- terms()
        wordcloud_rep(names(v), v, scale=c(6,.7),
                      min.freq = input$freq, max.words=input$max,
                      colors=brewer.pal(8, "Dark2"))
    })
}