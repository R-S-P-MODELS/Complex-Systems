myUI <- shinyUI({
ui <- fluidPage(
withMathJax(),
                    helpText('Este modulo espera um arquivo de 1 coluna que sera o elemento da serie temporal'),
			helpText('O valor de repeticao leva em conta a periodicidade da sua medida temporal (exemplo dias=7,mes=12,minutos=60'),
			helpText("O bloco de predicao se trata de quantos passos temporais deseja que o fit tente prever apos sua medida"), 
                    
  fileInput("arquits", "Insira seu arquivo de dados como arquivo .dat",
            accept = c(
              "text/dat",".dat")
  ),
   
  div(style="display:inline-block",numericInput(inputId = "repeticaots",
                  label = "Periodicidade",min=1,max=60,value=7   )),
  div(style="display:inline-block",numericInput(inputId = "previsaots",
                  label = "Predicao",min=0,max=60,value=3   )),
  div(style="display:inline-block",selectInput(inputId = "opcaodaserie",label="Tipo de modelo",choices = c("exponencial","arima") ) ),

# div(style="display:inline-block",textInput("text", label = h3("Digite a equacao a ser fitada"), value = "x^2+x") ),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("calculandoserie", "Realizar Calculo")
#downloadButton("downloadErro", "Download")


      
      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
