myUI <- shinyUI({
ui <- fluidPage(
  helpText("Este modulo representa um projeto discutido em processamento de sinais sobre filtros personalizados"),
helpText("No primeiro arquivo insira um arquivo de 2 colunas a primeira x segunda y associado, este será seu filtro" ),
helpText("No segundo arquivo insira um arquivo de 2 colunas a primeira x segunda y associado, este os dados que deseja filtrar" ),
helpText("Clique uma vez em calcular filtro apos convolucao , apos isto o valor de M se associara ao tamanho do kernel,selecione o desejado e ele te retornara o filtro associado" ),
helpText("Ao encontrar o filtro ideal clique em executar convolucao e a primeira curva retornara o sinal filtrado") ,
  fileInput("file1", "Insira seu filtro como arquivo .dat",
            accept = c(
              "text/dat",".dat")
  ),
  fileInput("file2", "Insira seu sinal a ser filtrado como arquivo .dat",
            accept = c(
              "text/dat",".dat")
  ),
#  div(style="display:inline-block",numericInput(inputId = "alfa",
 #                 label = "valor de alfa",
  #                min = 1,
   #               max = 50,
    #              value = 32)),

  #div(style="display:inline-block",numericInput(inputId = "beta",
   #               label = "Temperatura",
    #              min = 1,
     #             max = 50,
      #            value = 4)),

  #div(style="display:inline-block",numericInput(inputId = "rho",
   #               label = "Tempo de simulacao",
    #              min = 1e-10,
     #             max = 1e-7,
      #            value = 1e-9)),

  
  div(style="display:inline-block",sliderInput(inputId = "Passoskernel",
                  label = "M kernel",
                  min = 2,
                  max = 512,
                  value = 20)),
#  div(style="display:inline-block",selectInput(inputId = "Opcao_integ",label="tipo de integracao",choices = c("verlet","velocity verlet","Leap Frog") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_ini",label="tipo de inicializacao",choices = c("nula","Equiparticao","Boltzman") ) ),

#div(style="display:inline-block",selectInput(inputId = "Opcao_Resultado",label="tipo de Resultado",choices = c("G(r)","deslocamento quadratico","Energias") ) ) ,

actionButton("botaofiltrado", "Reajustar Filtro"),
actionButton("conv", "Calcular convolucao"),

downloadButton("downloadExemplo2", "arquivo de exemplos favor clique em reajustar filtro e calcular convolucao para gerar")

     # plotOutput(outputId = "distPlot")
      #counter <- reactiveValues(countervalue = 0)
  

)
})
