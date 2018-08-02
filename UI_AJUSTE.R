myUI <- shinyUI({
ui <- fluidPage(
withMathJax(),
                    helpText('Este modulo expande um conjunto de dados em uma serie polinomial,selecione o numero de termos no slider e inclua um arquivo de duas colunas, a primeira com eixo x e a segunda y '),
                    
  fileInput("arqui", "Insira seu arquivo de dados como arquivo .dat",
            accept = c(
              "text/dat",".dat")
  ),
   
  div(style="display:inline-block",sliderInput(inputId = "termosmaximos",
                  label = "Numero de termos maximos da expansao a se buscar",
                  min = 1,
                  max = 100,
                  value = 2)),

# div(style="display:inline-block",textInput("text", label = h3("Digite a equacao a ser fitada"), value = "x^2+x") ),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("calculando", "Iniciar ajuste"),

downloadButton("downloadCoeficientes", "Download dos coeficientes"),
downloadButton("downloadExemplo", "arquivo de exemplos favor clique em iniciar ajuste para gerar")


      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
