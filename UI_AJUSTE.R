myUI <- shinyUI({
ui <- fluidPage(

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

actionButton("calculando", "Iniciar ajuste")


      
      #counter <- reactiveValues(countervalue = 0)
  

)
}
)
