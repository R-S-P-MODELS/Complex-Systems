myUI <- shinyUI({
  fluidPage(		
title = 'Atrator de Lorentz',
                    withMathJax(),
                    helpText('O atrator de Lorentz e um mapa caotico que mostra como o estado de um sistema dinamico evolui no tempo num padrao complexo, nao-repetitivo,este e  descrito pelas seguintes equacoes '),
                    helpText("$$\\frac{dx}{dt}=\\alpha(y-x)$$"),
                    helpText("$$\\frac{dy}{dt}=x(\\rho -z) -y$$"),
                    helpText("$$\\frac{dz}{dt}=xy-\\beta z$$"),
                    helpText(" A solucao das equacoes e dada a seguir, onde x y z sao cordenadas espaciais"),
numericInput(inputId = "alfa3",
                  label = "valor de alfa",
                  min = 1,
                  max = 50,
                  value = 10),

numericInput(inputId = "beta3",
                  label = "valor de beta",
                  min = 1,
                  max = 50,
                  value = 2.6),

numericInput(inputId = "rho3",
                  label = "valor de rho",
                  min = 1,
                  max = 50,
                  value = 28),

numericInput(inputId = "Passos3",
                  label = "numero de passos",
                  min = 10,
                  max = 5000,
                  value = 300)


 )
}
)
