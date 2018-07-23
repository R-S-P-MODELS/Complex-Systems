myUI <- shinyUI({
fluidPage(
   
   # Application title
   titlePanel("Modelo Intra Hospedeiro"),
   withMathJax(),
   helpText('A seguir discutimos um modelo intra -hospedeiro para a tuberculose apresentada no artigo Within-host dynamics model for persistence and drug resistance of M. Tuberculosis'), 
   helpText('As equacoes que o regem sao as seguintes:'),
   helpText("$$\\frac{dS}{dt}=[1-q]v -(f+\\alpha)]S -\\gamma SI +gS_d -v\\frac{S+R}{k_b}S$$"),
   helpText("$$\\frac{dS_d}{dt}=fS-gS_d$$"),
   helpText("$$\\frac{dR}{dt}=qvS -(v_1+f+\\alpha)]R -\\gamma RI +gR_d -v_1\\frac{S+R}{k_b}R$$"),
   helpText("$$\\frac{dR_d}{dt}=fR-gR_d$$"),
   helpText("$$a=a_1-\\frac{a_1(S+R)^m}{a_2^m+(S+R)^m}$$"),
   helpText("$$\\frac{di_0}{dt}=a -\\epsilon \\frac{S+R}{k+S+R}i_0 -\\mu i_0  $$"),
   helpText("$$\\frac{di_j}{dt}=2\\epsilon \\frac{S+R}{k+S+R}i_{j-1} -\\mu i_j -\\epsilon  \\frac{S+R}{k+S+R}i_j  $$"),
   helpText("$$I=\\sum i_j$$"),
   helpText("Os parametros sao fixos de acordo com o artigo e permitimos o controle dos parametros associados ao individuo, S se trata da bacteria susceptivel, R da Resistente S_d, R_d suas versoes dormentes, I o sistema imune"),
	helpText("curva azul S(t) curva vermelha R(t)"),
   #                 helpText("$$\\frac{dI}{dt}=\\beta\\frac{SI}{N} - \\gamma  I$$"),
   # Sidebar with a slider input for number of bins 
       sliderInput("fwith",
                     "valor de f:",
                     min = 0,
                     max = 1,
                     value = 0.5),
         sliderInput(inputId = "a1",min =0,max = 1,value=0.1,label = "Valor de a1"),
        sliderInput(inputId = "remedio",min=0,max=1,value=0,label = "valor de alfa no ano 20"),
        actionButton("ativacao","execute")
        #selectInput(inputId = "onda",choices=c("psi","probabilidade"),label="opcoes")
      
      
      
   
)

})
