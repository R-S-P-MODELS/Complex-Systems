myUI <- shinyUI({
ui <- fluidPage(
withMathJax(),
                    helpText('Este modulo um arquivo MP3 afim de analisarmos a distribuicao de amplitudes durante esta'),
			helpText('Ao clicar em Realizar calculo o sistema te retornara uma mensagem calculando, apos ele realizar sera plotado o histograma'),
                    
  fileInput("arquimusica", "Insira seu arquivo de audio como arquivo .mp3",
            accept = c(
              "audio/mp3",".mp3")
  ),
   
  div(style="display:inline-block",selectInput(inputId = "opcoesmusicas",
                  label = "Opcoes de operacao",choices=c("Histograma")   )),

# div(style="display:inline-block",textInput("text", label = h3("Digite a equacao a ser fitada"), value = "x^2+x") ),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("calculandomusica", "Realizar histograma")
#downloadButton("downloadErro", "Download")


      
      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
