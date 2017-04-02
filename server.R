library(shiny)
library(chemometrics)

shinyServer(function(input, output) {


    output$plot <- renderPlot({
        fx <- as.numeric(input$factx)
        kf <- as.numeric(input$kfold)
        data(iris)
        set.seed(3)
        ntrain <- round(nrow(iris)*4/5)
        train <- sample(1:nrow(iris),ntrain)
        training <- iris[train,]
        testing <- iris[-train,]
        
        knnres <- knnEval(scale(iris[,-5]),iris[,5],train,kfold=kf, knnvec=seq(1,fx,by=1),legpos="bottomright")
        
        })
    
    calculate <- reactive({
        found <- 0
        kf <- as.numeric(input$kfold)
        fx <- as.numeric(input$factx)
        fl <- fx-5

        data(iris)
        set.seed(3)
        ntrain <- round(nrow(iris)*4/5)
        train <- sample(1:nrow(iris),ntrain)
        training <- iris[train,]
        testing <- iris[-train,]
        knnres <- knnEval(scale(iris[,-5]),iris[,5],train,kfold=kf, knnvec=seq(1,fx,by=1),plotit=FALSE)
        
        for (j in kf:1)
        {
            if (found==0){
            for (i in 1:fl) {
                if(found==0 
                   & knnres$cverr[j,i] < knnres$cverr[j,i+1] 
                   & knnres$cverr[j,i] < knnres$cverr[j,i+2] 
                   & knnres$cverr[j,i] < knnres$cverr[j,i+3] 
                   & knnres$cverr[j,i] < knnres$cverr[j,i+4] 
                   & knnres$cverr[j,i] < knnres$cverr[j,i+5])
                {
                    print(i);
                    found <- 1;
                    break;
                }
            if (found==1) break;
        }}}
        if (found==1) print(i)
        else print("Impossible to compute (yet)")
    })  
    
    output$pred <- renderText({
        calculate()
    })
})