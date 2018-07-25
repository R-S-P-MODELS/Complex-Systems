myUI <- shinyUI({
fluidPage(
   
   # Application title
   titlePanel("Teoria de Jogos-Dilema do Prisioneiro"),
   withMathJax(),
   helpText('A seguir discutimos um modelo que simula o equilibrio entre uma populacao de individuos que podem cooperar ou trair seus vizinhos de acordo com as regras do dilema do prisioneiro'), 
   helpText('Na interacao e calculado a funcao payoff'),
   helpText('Esta e entao normalizada por uma gaussiana de variancia sigma e media 50, o valor tomado como x desta sera a idade do individuo'),
   helpText('O argumento da normalizacao e que suas acoes tem maior peso na visao social em funcao de certos fatores de lideranca, entre eles a idade como gaussiana'),
      helpText("Os parametros de controle sao o incentivo a traicao, ou seja o valor T e a variancia da gaussiana, quando esta tende a 0 temos uma situacao ditatorial enquanto muito grande e um sistema sem lideres"),
	helpText("Azul traidores vermelho cooperadores"),

   #                 helpText("$$\\frac{dI}{dt}=\\beta\\frac{SI}{N} - \\gamma  I$$"),
   # Sidebar with a slider input for number of bins 
       sliderInput("traicao",
                     "valor de T:",
                     min = 1,
                     max = 2,
                     value = 1),
         sliderInput(inputId = "vargaussa",min =0.01,max = 100,value=5,label = "sigma"),
      #  sliderInput(inputId = "remedio",min=0,max=1,value=0,label = "valor de alfa no ano 20"),
        actionButton("ativacaoJogos","execute")
        #selectInput(inputId = "onda",choices=c("psi","probabilidade"),label="opcoes")
      
      
      
   
)

})
