myUI <- shinyUI({
  fluidPage(		
title = 'Modelo Epidemiologico SIS',
                    withMathJax(),
                    helpText('O Modelo SIS e descrito por 2 compartimentos Susceptivel e Infectado,estes sao regidos pelas equacoes: '),
                    helpText("$$\\frac{dS}{dt}=-\\beta\\frac{SI}{N} + \\gamma  I$$"),
                    helpText("$$\\frac{dI}{dt}=\\beta\\frac{SI}{N} - \\gamma  I$$"),
                    helpText(" A solucao das equacoes e dada a seguir, N se refere a populacao total S populacao susceptivel I Populacao Infectada"),
                    
                    numericInput(inputId = "alfa",
                                 label = "numero de pessoas",
                                 min = 1,
                                 max = 100000,
                                 value = 32),
                    
                    numericInput(inputId = "beta",
                                 label = "valor de beta (Taxa media de nascimento)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "rho",
                                 label = "valor de gamma (Tempo infeccioso medio)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "Passos",
                                 label = "numero de passos",
                                 min = 10,
                                 max = 50000,
                                 value = 30),
                    
                    sliderInput(inputId = "infeccao",
                                label = "proporcao de infectados em t=0",
                                min = 0,
                                max = 1,
                                value = 0.1)
)
})
