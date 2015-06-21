# load libraries
library(shiny)
library(devtools)
sample_size<-100
x<-(1:sample_size)*10/sample_size
y<-x+sin(x)+rnorm(sample_size,0,0.3)
x2<-x^2
x3<-x^3
x4<-x^4
x5<-x^5
x6<-x^6
x7<-x^7
x8<-x^8
x9<-x^9
x10<-x^10

dat1<-cbind(y,x)
dat2<-cbind(y,x,x2,x3)
dat3<-cbind(y,x,x2,x3,x4,x5)
dat4<-cbind(y,x,x2,x3,x4,x5,x6,x7,x8,x9,x10)

samp<-seq(from = 1, to = sample_size, by = 10) 
dat1_test<-dat1[samp,]
dat1_train<-dat1[-samp,]
dat2_test<-dat2[samp,]
dat2_train<-dat2[-samp,]
dat3_test<-dat3[samp,]
dat3_train<-dat3[-samp,]
dat4_test<-dat4[samp,]
dat4_train<-dat4[-samp,]

modelfit1<-lm(y~x,data=as.data.frame(dat1_train))
modelfit2<-lm(y~x+x2+x3,data=as.data.frame(dat2_train))
modelfit3<-lm(y~x+x2+x3+x4+x5,data=as.data.frame(dat3_train))
modelfit4<-lm(y~x+x2+x3+x4+x5+x6+x7+x8+x9+x10,data=as.data.frame(dat4_train))
pred1<-predict(modelfit1,as.data.frame(dat1_test), se.fit = TRUE)
pred2<-predict(modelfit2,as.data.frame(dat2_test), se.fit = TRUE)
pred3<-predict(modelfit3,as.data.frame(dat3_test), se.fit = TRUE)
pred4<-predict(modelfit4,as.data.frame(dat4_test), se.fit = TRUE)

err1<-as.character(sqrt(sum(((dat1_test[,2]-pred1$fit)^2))/10))
err2<-as.character(sqrt(sum(((dat2_test[,2]-pred2$fit)^2))/10))
err3<-as.character(sqrt(sum(((dat3_test[,2]-pred3$fit)^2))/10))
err4<-as.character(sqrt(sum(((dat4_test[,2]-pred4$fit)^2))/10))



shinyServer(function(input, output, session){
  
  formulaText <- reactive({
    
    if (input$variable=="err1") pr<-err1
    if (input$variable=="err2") pr<-err2
    if (input$variable=="err3") pr<-err3
    if (input$variable=="err4") pr<-err4
    paste("Standart error", pr) 
  })
  output$caption <- renderText({
    formulaText()
  })
})