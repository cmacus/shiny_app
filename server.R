#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
data(iris)
inTrain <- createDataPartition(y=iris$Species,p=0.75,list=FALSE)
tr <- iris[inTrain,]
ts <- iris[-inTrain,]
mod_rpart <- train(Species ~ .,tr,method='rpart')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    plot(c(input$Sepal.Length,input$Sepal.Width,input$Petal.Length,input$Petal.Width),ylab='Params',pch=19,col='red')
  })
  output$species <- reactive(predict(mod_rpart,data.frame(Sepal.Length=input$Sepal.Length,
                                                 Sepal.Width=input$Sepal.Width,
                                                 Petal.Length=input$Petal.Length,
                                                 Petal.Width=input$Petal.Width)))
})

