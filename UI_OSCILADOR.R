myUI <- shinyUI({
fluidPage(
withMathJax(),
helpText("O problema do Oscilador Harmonico Quantico e dado por uma equacao de auto valores dada pela expressao:"),
helpText("$$H\\Psi=E\\Psi$$"),
helpText("Onde E se refere a energia e a hamiltoniana e dada por:"),
helpText("$$H=\\frac{\\hbar^2 d^2}{2mdx^2} +k\\frac{x^2}{2} $$"),
helpText("Esta tem niveis de energias discretos e funcoes de ondas associadas a cada nivel demonstrados a seguir onde 0 se refere ao estado fundamental"),
   # Application title
   titlePanel("Oscilador Harmonico Quantico"),
   
   # Sidebar with a slider input for number of bins 
  
         sliderInput("termos",
                     "Nivel de energia buscado:",
                     min = 0,
                     max = 60,
                     value = 2),
         numericInput(inputId = "caixa",min =5,max = 15,value=10,label = "Tamanho da caixa recomendado 10"),
        numericInput(inputId = "dxcaixa",min=100,max=3000,value=100,label = "numero de subsdivisoes")

      
      
 
   
)
})
