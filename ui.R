#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Optimal number of k-steps in k-NN algorithm"),
    em("This application uses the iris dataset and applies the nearest neighbors algorithm with folding in order to predict the Species."),
    h3(""),
    em("It is possible to input below the number of neighbors and the number of folds to be considered"),
    em("and a plot will be drawn depicting the test set error, cross validated error and training set error"),
    em("as factor of the input parameters."),
    h3(""),
    em("The number of neighbors for which the algorithm performs optimally is also printed in the right panel."),
    h3(""),
    h3(""),
    sidebarLayout(
        sidebarPanel(
            sliderInput("factx", "What is the number of nearest neighbors?", 20, 100, value = 30),
            textInput("kfold", "Enter number of folds:", value = 10),
            submitButton("Submit")
            ),
        mainPanel(
            h3("k at which the error rate starts to increase:"),
            textOutput("pred"),
            plotOutput("plot")
        )
    )
))