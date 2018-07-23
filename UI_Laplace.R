myUI <- shinyUI({
fluidPage(
withMathJax(),
helpText("O problema da equacao de laplace e dada por uma equacao diferencial dada pela expressao:"),
helpText("$$\\nabla^2V=0 $$"),
helpText("Onde V se refere ao potencial eletrico, este pode ser distribuido por diversas condicoes de contorno:"),
helpText("Neste modulo mostramos as condicoes de contorno de uma casca esferica, uma placa capacitiva e um retangulo"),
   # Application title
   titlePanel("Potencial de Laplace"),
   
   # Sidebar with a slider input for number of bins 
  	selectInput(inputId="opcaocontorno",label="Condicoes de contorno",choices=c("Capacitor","Casca circular","Retangulo")),
                numericInput(inputId = "tensaolaplace",min =-50,max = 50,value=10,label = "Tensao aplicada na condicao de contorno"),
        selectInput(inputId="aterramento",label="Deseja aterrar a placa?",choices=c("Sim","Nao")),
      
      actionButton("botaolaplace", "Realizar calculo")
 
   
)
})
