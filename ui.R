#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting species from morphology"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("Sepal.Length",
                   "Sepal length",
                   min = 4,
                   max = 8,
                   value = 4),
       sliderInput("Sepal.Width",
                   "Sepal width",
                   min = 2,
                   max = 4.5,
                   value = 2),
       sliderInput("Petal.Length",
                   "Petal length",
                   min = 1,
                   max = 7,
                   value = 1),
       sliderInput("Petal.Width",
                   "Petal width",
                   min = 0,
                   max = 3,
                   value = 0)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      p('This application trains an rpart model from the iris dataset. The plot made from the four
        input parameters. The prediction model outputs the species. Change the values of the 
        slider and the application will show the prediction'),
      pre('library(shiny)
library(caret)
data(iris)
inTrain <- createDataPartition(y=iris$Species,p=0.75,list=FALSE)
tr <- iris[inTrain,]
ts <- iris[-inTrain,]
mod_rpart <- train(Species ~ .,tr,method="rpart")
output$species <- reactive(predict(mod_rpart,data.frame(Sepal.Length=input$Sepal.Length,
                                                 Sepal.Width=input$Sepal.Width,
                                                 Petal.Length=input$Petal.Length,
                                                 Petal.Width=input$Petal.Width)))
'),
       plotOutput("distPlot"),
       h4('Species'),
       verbatimTextOutput("species")
    )
  )
))