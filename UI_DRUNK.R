myUI <- shinyUI({
  fluidPage(		
title = 'Andar do bebado',
                    withMathJax(),
                    helpText('O andar do bebado e um problema classico tratado em termodinamica '),
                    helpText("Um bebado tem probabilidade p de andar pra frente e 1-p de andar para tras"),
                    helpText("O passo do bebado e independente do passo anterior ou seja um processo markoviano"),
                    helpText(" Nesta simulacao simulamos o andar de n bebados em um sistema unidimensional e geramos um histograma de suas posicoes finais"),
                    
                    numericInput(inputId = "bebados",
                                 label = "numero de bebados simulados",
                                 min = 1,
                                 max = 100000,
                                 value = 32),
                    
                                        
                    numericInput(inputId = "Largura",
                                 label = "Largura do passo",
                                 min = 1,
                                 max = 10,
                                 value = 1),
                    
                    numericInput(inputId = "Passosx",
                                 label = "numero de passos do bebado",
                                 min = 10,
                                 max = 50000,
                                 value = 30),
                    
                    sliderInput(inputId = "Probabilidade",
                                label = "Probabilidade de andar para a frente",
                                min = 0,
                                max = 1,
                                value = 0.5)
)
})
