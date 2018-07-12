myUI <- shinyUI({
fluidPage(
   
   # Application title
   titlePanel("Modelo Intra Hospedeiro"),
   
   # Sidebar with a slider input for number of bins 
       sliderInput("fwith",
                     "valor de f:",
                     min = 0,
                     max = 1,
                     value = 0.5),
         sliderInput(inputId = "a1",min =0,max = 1,value=0.1,label = "Valor de a1"),
        sliderInput(inputId = "remedio",min=0,max=1,value=0,label = "valor de alfa no ano 20"),
        actionButton("ativacao","execute")
        #selectInput(inputId = "onda",choices=c("psi","probabilidade"),label="opcoes")
      
      
      
   
)

})
