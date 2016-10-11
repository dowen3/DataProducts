#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("What 1974 Automobile is Right for You?"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(

    sidebarPanel(p("This app will tell you what kind of 1974 model car is right for 
                  you based on your preferences for fuel economy and transmission type.
                   The resulting cars are listed to the right. The plot below gives more 
                   detailed information on the vehicle, including quarter mile time in 
                   seconds (qsec, yaxis), number of cylinders (cyl, shape of point), 
                    and weight (wt, size of point) of the vehicle in 1000lbs  for easy 
                   visual comparison between models"),
       sliderInput("mpg",
                   "Minimum miles per gallon:",
                   min = 1,
                   max = 50,
                   value = 20),
       selectInput("trans", 
                   "Transmission Type", 
                   c("Either", "Automatic", "Manual"),
                   selected = "Either")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(textOutput("names"), 
              plotlyOutput("distPlot")
       
    )
  )
))