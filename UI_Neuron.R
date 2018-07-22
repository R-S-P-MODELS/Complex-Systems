myUI <- shinyUI({
fluidPage(
	
   withMathJax(),

                    helpText('Neste Modulo discutimos um problema de sincronizacao da informacao em uma populacao utilizando um grafo direcionado para representar suas conexoes'),
		    helpText('O individuo sera simulado utilizando se os mesmos conceitos de um Neuronio, onde este ira acumular tensao ate o seu treshhold, aonde este ira disparar transmitindo informacao a seus vizinhos'),
		    helpText('O valor disparado por um individuo será dado por $ \\rho T$ onde T representa o valor do treshhold, $\\rho$ varia para cada individuo, onde a inicializacao sera dada por uma gaussiana'),
		    helpText('Os parametros desta sao inicializados pelo usuario, esta e cortada de forma que $0<\\rho<1$'),

   # Application title
   titlePanel("Modelo Neuronios"),
   
   # Sidebar with a slider input for number of bins 
       sliderInput("conectividade",
                     "Parametro de conectividade:",
                     min = 0,
                     max = 1,
                     value = 0.5),
         sliderInput(inputId = "mediagauss",min =0,max = 1,value=0.1,label = "Media da gaussiana de distribuicao"),
        sliderInput(inputId = "vargauss",min=0,max=1,value=0,label = "variancia da gaussiana de  distribuicao"),
        actionButton("ativacaoneuron","execute")
        #selectInput(inputId = "onda",choices=c("psi","probabilidade"),label="opcoes")
      
      
      
   
)

})
