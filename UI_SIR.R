myUI <- shinyUI({
  fluidPage(		
title = 'Modelo Epidemiologico SIR',
                    withMathJax(),
                    helpText('O Modelo SIR e descrito por 3 compartimentos Susceptivel,Infectado e Resistente estes sao regidos pelas equacoes: '),
                    helpText("$$\\frac{dS}{dt}=-\\beta\\frac{SI}{N}$$"),
                    helpText("$$\\frac{dI}{dt}=\\beta\\frac{SI}{N} - \\gamma  I$$"),
                    helpText("$$\\frac{dR}{dt}=\\gamma  I$$"),
                    helpText(" A solucao das equacoes e dada a seguir, N se refere a populacao total S populacao susceptivel I Populacao Infectada"),
                    
                    numericInput(inputId = "alfa1",
                                 label = "numero de pessoas",
                                 min = 1,
                                 max = 100000,
                                 value = 32),
                    
                    numericInput(inputId = "beta1",
                                 label = "valor de beta (Taxa media de nascimento)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "rho1",
                                 label = "valor de gamma (Tempo infeccioso medio)",
                                 min = 0,
                                 max = 1,
                                 value = 0.5),
                    
                    numericInput(inputId = "Passos1",
                                 label = "numero de passos",
                                 min = 10,
                                 max = 50000,
                                 value = 30),
                    
                    sliderInput(inputId = "infeccao1",
                                label = "proporcao de infectados em t=0",
                                min = 0,
                                max = 1,
                                value = 0.1)
                    
)
})
