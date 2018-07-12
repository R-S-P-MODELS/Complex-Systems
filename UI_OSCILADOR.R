myUI <- shinyUI({
fluidPage(
   
   # Application title
   titlePanel("Oscilador Harmonico Quantico"),
   
   # Sidebar with a slider input for number of bins 
  
         sliderInput("termos",
                     "Nivel de energia buscado:",
                     min = 0,
                     max = 60,
                     value = 2),
         numericInput(inputId = "caixa",min =5,max = 15,value=10,label = "Tamanho da caixa recomendado 10"),
        numericInput(inputId = "dxcaixa",min=100,max=3000,value=100,label = "numero de subsdivisoes"),
        selectInput(inputId = "onda",choices=c("psi","probabilidade"),label="opcoes")
      
      
 
   
)
})
