#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
mtcars$am<-as.factor(mtcars$am)
mtcars$cyl<-as.factor(mtcars$cyl)
levels(mtcars$am)[levels(mtcars$am)=="0"] <- "Automatic"
levels(mtcars$am)[levels(mtcars$am)=="1"] <- "Manual"
name<-rownames(mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlotly({
    if (input$trans=="Either"){yn<-mtcars$mpg > input$mpg
      if(sum(yn)==length(yn)){g<-ggplot(data = mtcars, aes(mpg, qsec, label=name))
      g<-g+geom_point(aes(color = am, shape = cyl, size = wt ))
      g<-g+ theme(legend.position = "bottom", legend.box = "horizontal")
      ##Note the absence of alpha in the above geom_point. If all of the cars meet the required
      ##mpg then there is only one level of yn (all values are 1). Assigning an alpha to this
      ##would default all points to being a low alpha and thus transparent.
      ggplotly(g, tooltip = c("name","am", "mpg", "qsec", "cyl", "wt"))}
    
      else{g<-ggplot(data = mtcars, aes(mpg, qsec, label=name))
        g<-g+geom_point(aes(color = am, shape = cyl, alpha = yn, size = wt ))
        g<-g+ theme(legend.position = "bottom", legend.box = "horizontal")
        ggplotly(g, tooltip = c("name","am", "mpg", "qsec", "cyl", "wt"))}
    }
    
    else{yn<- mtcars$mpg > input$mpg & mtcars$am==input$trans
      
    g<-ggplot(data = mtcars, aes(mpg, qsec, label=name))
    g<-g+geom_point(aes(color = am, shape = cyl, alpha = yn, size = wt ))
    g<-g+ theme(legend.position = "bottom", legend.box = "horizontal")
    ggplotly(g, tooltip = c("name","am", "mpg", "qsec", "cyl", "wt"))}
    
  })
   
output$names<-renderText({if (input$trans=="Either"){
                      yn<-mtcars$mpg > input$mpg
                      paste(rownames(mtcars)[yn], collapse =", ")}
  else{paste(rownames(mtcars)[mtcars$mpg > input$mpg & mtcars$am==input$trans], collapse =", ")}
  
})
})
