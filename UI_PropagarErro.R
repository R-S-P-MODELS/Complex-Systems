myUI <- shinyUI({
ui <- fluidPage(
withMathJax(),
                    helpText('Este modulo espera um arquivo de 4 colunas escritas como x y dx dy aonde ele pode realizar as operacoes y+x, y-x, y*x, y/x'),
			helpText('Ao clicar em Realizar calculo o sistema te retornara uma mensagem calculando, apos ele realizar a mensagem calculado clique no botao download'),
                    
  fileInput("arquierro", "Insira seu arquivo de dados como arquivo .dat",
            accept = c(
              "text/dat",".dat")
  ),
   
  div(style="display:inline-block",selectInput(inputId = "opcoeserro",
                  label = "Opcoes de operacao",choices=c("soma","subtracao","produto","divisao")   )),

# div(style="display:inline-block",textInput("text", label = h3("Digite a equacao a ser fitada"), value = "x^2+x") ),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("calculandoerro", "Realizar Calculo"),
downloadButton("downloadErro", "Download"),
downloadButton("downloadExemplo1", "arquivo de exemplos favor clique em realizar para gerar")


      
      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
