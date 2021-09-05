#we need to configure my current version of python with R
#reticulate::py_config()
#PATH = D:\Anaconda\python.exe
#Sys.setenv(RETICULATE_PYTHON = PATH)

#this is the python installation instead

#D:\Anaconda\envs\tensorflow\python.exe

#sets up a new environment to use tensorflow in

#reticulate::conda_create(envname = "r-reticulate")

#didn't work
#library (tensorflow)
#Sys.setenv(RETICULATE_PYTHON="D:/Anaconda/envs/tensorflow/python")

#try again


#temporarily set my working directory to where all_species are kept, so I can generate the labelist
#this information is from the first tutorial: https://forloopsandpiepkicks.wordpress.com/2021/03/16/how-to-build-your-own-image-recognition-app-with-r-part-1/

#setwd("C:/users/my_name/desktop/birds")

#to extract the labels list
#setwd("F:/all_species_cropped_balanced")


#repeated on the 23rd of August to include the blue winged leafbird
#setwd("Z:/all_species_cropped_balanced")

#label_list <- dir("train/")
#output_n <- length(label_list)
#save(label_list, file="label_list.RData")


#densenet file from the one computed on the supercomputer

#setwd("D:/Sicily/Documents/R/All R/birdapp")

#make sure you have the correct version of Tensorflow

#tensorflow::install_tensorflow(extra_packages='pillow')

#to check that my Tensorflow is working
library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)
library (png)

model <- load_model_tf("www/bird_mod/")
load("www/label_list.RData")
target_size <- c(224,224,3)
options(scipen=999)

title <- tags$a(href='https://github.com/Sicily-F/cagedbirdID',
               tags$img(src='https://github.com/Sicily-F/cagedbirdID/blob/06595c5bfab7c0690ca594d21a7feb3a9bb4150d/logo.png', height = '50', # was 50 originally,
               width= '50'),
               'cagedbirdID', style="font-size: 120%; font-weight: bold; color: white")




ui <- fluidPage(
  dashboardPage(
  skin="blue",
  
  #(1) Header
  
  
  dashboardHeader(title= title,
                    #tags$h1("cagedbirdID App",style="font-size: 120%; font-weight: bold; color: white"),
                  titleWidth = 350,
                  tags$li(class = "dropdown"),
                  dropdownMenu(type = "notifications", icon = icon("question-circle", "fa-1x"), badgeStatus = NULL,
                               headerText="",
                               tags$li(a(href = "https://twitter.com/sicilyfiennes",
                                         target = "_blank",
                                         tagAppendAttributes(icon("icon-circle"), class = "info"),
                                         "Created by Sicily Fiennes"))
                  )),
  
  
  #(2) Sidebar
  
  dashboardSidebar(
    width=350,
    fileInput("input_image","File" ,accept = c('.jpg','.jpeg','.png')), 
    tags$br(),
    tags$p("Upload the image here.")
  ),
  
  
  #(3) Body
  
  dashboardBody(
    
    h4("Instruction:"),
    tags$br(),tags$p("1. Take a picture of a bird."),
    tags$p("2. Crop image so that bird fills out most of the image."),
    tags$p("3. Upload image with menu on the left."),
    tags$br(),
    
    fluidRow(
      column(h4("Image:"),imageOutput("output_image"), width=6),
      column(h4("Prediction:"),tags$br(),textOutput("warntext",), tags$br(),
             tags$p("This bird is most likely a:"),tableOutput("text"),width=6)
    ),tags$br()
    
  )))


server <- function(input, output) {
  
  image <- reactive({image_load(input$input_image$datapath, target_size = target_size[1:2])})
  
  
  prediction <- reactive({
    if(is.null(input$input_image)){return(NULL)}
    x <- image_to_array(image())
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255
    pred <- model %>% predict(x)
    pred <- data.frame("Bird" = label_list, "Confidence" = t(pred))
    pred <- pred[order(pred$Prediction, decreasing=T),][1:5,]
    pred$Prediction <- sprintf("%.2f %%", 100*pred$Prediction)
    pred
  })
  
  output$text <- renderTable({
    prediction()
  })
  
  output$warntext <- renderText({
    req(input$input_image)
    
    if(as.numeric(substr(prediction()[1,2],1,4)) >= 30){return(NULL)}
    warntext <- "Warning: I am not sure about this bird!"
    warntext
  })
  
  
  output$output_image <- renderImage({
    req(input$input_image)
    
    outfile <- input$input_image$datapath
    contentType <- input$input_image$type
    list(src = outfile,
         contentType=contentType,
         width = 400)
  }, deleteFile = TRUE)
  
}


shinyApp(ui, server)



#for some reason the version of tensorflow that I downloaded doesn't have pillow
#so we will try this code and then re-run

#error: The Pillow Python package is required to load images

#currently: accept = c('.jpg','.jpeg')
