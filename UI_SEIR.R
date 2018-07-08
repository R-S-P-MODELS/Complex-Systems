myUI <- shinyUI({
  fluidPage(		
title = 'Modelo Epidemiologico SEIR',
                    withMathJax(),
                    helpText('O Modelo SEIR e descrito por 4 compartimentos Susceptivel,Exposto,Infectado e Resistente estes sao regidos pelas equacoes: '),
                    helpText("$$\\frac{dS}{dt}=-\\beta\\frac{SI}{N}$$"),
                    helpText("$$\\frac{dE}{dt}=\\beta\\frac{SI}{N} - \\mu  E$$"),
                    helpText("$$\\frac{dI}{dt}=\\mu E - \\gamma  I$$"),
                    helpText("$$\\frac{dR}{dt}=\\gamma  I$$"),
                    helpText(" A solucao das equacoes e dada a seguir, N se refere a populacao total S populacao susceptivel I Populacao Infectada"),
                    
                    numericInput(inputId = "alfa2",
                                 label = "numero de pessoas",
                                 min = 1,
                                 max = 100000,
                                 value = 32),
                    
                    numericInput(inputId = "beta2",
                                 label = "valor de beta (Taxa media de nascimento)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "mu",
                                 label = "valor de mu (inverso do tempo de latencia)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "rho2",
                                 label = "valor de gamma (Tempo infeccioso medio)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "Passos2",
                                 label = "numero de passos",
                                 min = 10,
                                 max = 50000,
                                 value = 30),
                    
                    sliderInput(inputId = "infeccao2",
                                label = "proporcao de infectados em t=0",
                                min = 0,
                                max = 1,
                                value = 0.1)
                   # plotOutput(outputId = "distPlot")
                    
                    
)
})
