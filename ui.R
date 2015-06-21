# load shiny package
library(shiny)
library(devtools)
# begin shiny UI
shinyUI(pageWithSidebar(
  headerPanel('Why is not the most complicated regression model the best?'),
  
  sidebarPanel(
    h4("Select the type of the model"),
    selectInput("variable", "Model:",
                list("Linear model" = "err1", 
                     "Cubic model" = "err2", 
                     "Fifth Degree Polynomials" = "err3",
                     "Tenth Degree Polynomials" = "err4"))),
  mainPanel(
    p("Let's create the sample of random data (y=x+sin(x)+random noise),choose the type of the model and try to predict several values which was excluded from the train set."),
    p("We can see that standart error of the predicted values increases as long as the model becomes more complicated."),
    h4("Here is the standart error of the predicted values"),
  
  h4(textOutput("caption")))))
