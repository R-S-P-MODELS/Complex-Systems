myUI <- shinyUI({
ui <- fluidPage(
withMathJax(),
                    helpText('Este modulo discute um problema de sobrevivencia no Titanic, temos como informacao classe da passagem,nome ,genero, idade,numero de parentes, Pais no navio, valor da passagem'),
			
                    
  
   
  div(style="display:inline-block",selectInput(inputId = "opcoeserro",
                  label = "Opcoes de operacao",choices=c("soma","subtracao","produto","divisao")   )),

# div(style="display:inline-block",textInput("text", label = h3("Digite a equacao a ser fitada"), value = "x^2+x") ),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("calculandoerro", "Realizar Calculo"),
downloadButton("downloadErro", "Download")


      
      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
