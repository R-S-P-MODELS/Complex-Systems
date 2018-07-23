#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
packages <- c("ggplot2","shiny","pracma","tuneR","markdown")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
require(shiny)
require(ggplot2)
require(pracma)
require(tuneR)
require(markdown)
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  options(shiny.maxRequestSize = 30000*1024^2)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

sinal<-function(m,a){
  #a=read.table("input.dat")
  #a[2]=2
  #a[3:100]=3:100
  #print(a)
  b=fft(a[,2])
  n=as.integer(m/2)
  #print(length(b))
  #m=45
  if(m<length(b)*0.5)
    b[(n+1):(length(b)-n)]=0
  #print(b)
  c=ifft(b)
  u=data.frame(a[,1],Re(c),Re(b)  )
  
  #u=data.frame(a[,1],Re(c))
  p1=qplot(u[,1],u[,2],geom="line",xlab="x",ylab="y")
  #p2=qplot(u[,1],u[,3],geom="line",xlab="x",ylab="y")
  p2=qplot(u[,1],Mod(b),geom="line",xlab="x",ylab="y")
  multiplot(p1, p2,cols=2)
  write.table(file="saida.dat",u)
}

convolucao<-function(b){
  a=read.table("saida.dat")
  x=convolve(a[,2],b[,2],type="open")
  w=1:length(x)
  #hu=1:length(b)
  p1=qplot(w,x,geom="line",xlab="x",ylab="y")
  p2=qplot(a[,1],a[,2],geom="line",xlab="x",ylab="y")
  p3=qplot(b[,1],b[,2],geom="line",xlab="x",ylab="y")
  multiplot(p1, p2,p3,cols=2)
  
}

ajuste<-function(a,w){ 
  #print(a)
  #a sera o data.frame do arquivo x por y
  x=length(a[,1])
  #print(x)
  print(w)
  erro=0
  erro[2]=0
  B=a[,2]
  for(j in 1:w){
    A=matrix(0,x,j)
    for(i in 1:j)
      A[,i]=a[,1]^(i-1) # inicializacao da matriz
    print(j)
    X=solve(t(A)%*%A,t(A)%*%B)
    erro[j-1]=sum(abs(A%*%X -B))
  }
  #print(erro)
  d=which(min(erro)==erro)
  d=d+1
  A=matrix(0,x,d)
  for(i in 1:d)
    A[,i]=a[,1]^(i-1)
  X=solve(t(A)%*%A,t(A)%*%B) ## constantes x
  print(X)
  final=data.frame(a,A%*%X)
  plot(final[,1],final[,2],xlab="x",ylab = "y",main="F(x)")
  lines(final[,1],final[,3])
  write.table(file="dataset.dat",final)
}

ajusteunico<-function(a,w){ 
  #print(a)
  #a sera o data.frame do arquivo x por y
  x=length(a[,1])
  #print(x)
  print(w)
  erro=0
  erro[2]=0
  B=a[,2]
  fit2 <- lm(a[,2]~poly(a[,1],w,raw=TRUE))
  plot(a[,1],a[,2],xlab="x",ylab = "y",main="F(x)")
  lines(a[,1], predict(fit2, data.frame(x=a[,1])), col="red")
  renderPrint(coefficients(fit2))
  #write.table(file="dataset.dat",final)
}


drunk <- function(p,passos,pessoas,largura){
  assemble=0
  assemble[2]=0
  for(i in 1:pessoas)
  {
    b=runif(passos,min = 0,max=100)
    c=as.numeric(b<=(p*100) )
    d=length(b)-sum(c)
    #c=c-as.numeric(b<(p*100) )
    assemble[i]=largura*(sum(c) -d )
  }  
  
  write.table(file="dataset.dat",assemble)
  
}

lorentz <- function(alfa,beta,rho,passos) {
  dt=0.01
  x=1
  y=1
  z=1
  x[2]=2
  y[2]=3
  z[2]=4
  x[3]=y[3]=z[3]=2
  for (t in 2:(2+passos) ){
  #print(t)
  x[t]=x[t-1]+alfa*(y[t-1]-x[t-1] )*dt
  y[t]=y[t-1]+(x[t]*(rho-z[t-1]) -y[t-1])*dt
  z[t]=z[t-1] +dt*(x[t]*y[t]-beta*z[t-1])
  }
  #aux=read.table("lixo.dat")
  #aux[1,]=x
  #aux[2,]=y
  #aux[3,]=z
  aux=data.frame(x,y,z)
  #print(aux)
  #aux=t(aux)
  write.table(aux,file="dataset.dat")
}




SIS <- function(N,beta,gamma,passos,infeccaoinicial) {
  dt=0.01
  tempo=0
  S=N*(1-infeccaoinicial)
  I=N*infeccaoinicial
  #z=1
  S[2]=2
  I[2]=3
  #z[2]=4
  #x[3]=y[3]=z[3]=2
  for (t in 2:(2+passos) ){
    #print(t)
    tempo[t]=t*dt
    S[t]=S[t-1]+(-beta*S[t-1]*I[t-1]/N +gamma*I[t-1])*dt
    I[t]=I[t-1]+ (+beta*S[t-1]*I[t-1]/N -gamma*I[t-1])*dt
    #x[t]=x[t-1]+alfa*(y[t-1]-x[t-1] )*dt
    # y[t]=y[t-1]+(x[t]*(rho-z[t-1]) -y[t-1])*dt
    #z[t]=z[t-1] +dt*(x[t]*y[t]-beta*z[t-1])
  }
  #aux=read.table("lixo.dat")
  #aux[1,]=x
  #aux[2,]=y
  #aux[3,]=z
  aux=data.frame(tempo,S,I)
  #print(aux)
  #aux=t(aux)
  write.table(aux,file="dataset.dat")
}

SIR <- function(N,beta,gamma,passos,infeccaoinicial) {
  dt=0.01
  tempo=0
  S=N*(1-infeccaoinicial)
  I=N*infeccaoinicial
  R=0
  #z=1
  S[2]=2
  I[2]=3
  R[2]=0
  #z[2]=4
  #x[3]=y[3]=z[3]=2
  for (t in 2:(2+passos) ){
    #print(t)
    tempo[t]=t*dt
    S[t]=S[t-1]+(-beta*S[t-1]*I[t-1]/N )*dt
    I[t]=I[t-1]+ (+beta*S[t-1]*I[t-1]/N -gamma*I[t-1])*dt
    R[t]=R[t-1]+gamma*I[t-1]*dt
    #x[t]=x[t-1]+alfa*(y[t-1]-x[t-1] )*dt
    # y[t]=y[t-1]+(x[t]*(rho-z[t-1]) -y[t-1])*dt
    #z[t]=z[t-1] +dt*(x[t]*y[t]-beta*z[t-1])
  }
  #aux=read.table("lixo.dat")
  #aux[1,]=x
  #aux[2,]=y
  #aux[3,]=z
  aux=data.frame(tempo,S,I,R)
  #print(aux)
  #aux=t(aux)
  write.table(aux,file="dataset.dat")
}


SEIR <- function(N,beta,gamma,passos,infeccaoinicial,mu) {
  dt=0.01
  tempo=0
  S=N*(1-infeccaoinicial)
  E=R=0
  I=N*infeccaoinicial
  R=0
  #z=1
  S[2]=2
  I[2]=3
  R[2]=0
  E[2]=0
  #z[2]=4
  #x[3]=y[3]=z[3]=2
  for (t in 2:(2+passos) ){
    #print(t)
    tempo[t]=t*dt
    S[t]=S[t-1]+(-beta*S[t-1]*I[t-1]/N )*dt
    E[t]=E[t-1] +beta*S[t-1]*I[t-1]/N *dt -mu *E[t-1] *dt
    I[t]=I[t-1] - gamma*I[t-1]*dt +mu *E[t-1] *dt
    R[t]=R[t-1]+gamma*I[t-1]*dt
    #x[t]=x[t-1]+alfa*(y[t-1]-x[t-1] )*dt
    # y[t]=y[t-1]+(x[t]*(rho-z[t-1]) -y[t-1])*dt
    #z[t]=z[t-1] +dt*(x[t]*y[t]-beta*z[t-1])
  }
  #aux=read.table("lixo.dat")
  #aux[1,]=x
  #aux[2,]=y
  #aux[3,]=z
  aux=data.frame(tempo,S,E,I,R)
  #print(aux)
  #aux=t(aux)
  write.table(aux,file="dataset.dat")
}




# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
  selectInput(inputId = "materias",label = "Area",choices=c("Fisica Teorica","Fisica Experimental","Sistemas Complexos","Data Science") ),
  uiOutput("Drop1"),
  #div(style="display:inline-block",selectInput(inputId = "hue",label="opcao",choices = c("SIS","SIR","SEIR","Atrator de Lorentz","Andar do Bebado","Ajuste de curva","Filtro Personalizado","Oscilador Quantico","Intra Hospedeiro","Informacao Neuronios") ) ),      
  conditionalPanel( condition = "input.hue=='SIS'",
                    source("UI_SIS.R", local = TRUE)$value
                    
                    
                    ),
  
  conditionalPanel( condition = "input.hue=='SIR'",
                    source("UI_SIR.R",local=TRUE)$value
                    
  ),
  
  conditionalPanel( condition = "input.hue=='SEIR'",
                    source("UI_SEIR.R",local=TRUE)$value
                    
  ),
  
  conditionalPanel( condition = "input.hue=='Atrator de Lorentz'",
                    source("UI_LORENTZ.R",local=TRUE)$value
                    
  ),
  
  conditionalPanel( condition = "input.hue=='Andar do Bebado'",
                    source("UI_DRUNK.R",local=TRUE)$value
                    
  ),
  conditionalPanel( condition = "input.hue=='Ajuste de curva'",
                    source("UI_AJUSTE.R",local=TRUE)$value
                    
  ),
  
  conditionalPanel( condition = "input.hue=='Filtro Personalizado'",
                    source("UI_Filtro.R",local=TRUE)$value
                    
  ),
  
 conditionalPanel( condition = "input.hue=='Oscilador Quantico'",
                    source("UI_OSCILADOR.R",local=TRUE)$value
                    
  ),
 
 conditionalPanel( condition = "input.hue=='Intra Hospedeiro'",
                   source("UI_Intra.R",local=TRUE)$value
                   
 ),

 conditionalPanel( condition = "input.hue=='Informacao Neuronios'",
                   source("UI_Neuron.R",local=TRUE)$value
                   
 ),
 conditionalPanel( condition = "input.hue=='Propagar Erro'",
                   source("UI_PropagarErro.R",local=TRUE)$value
                   
 ),
 conditionalPanel( condition = "input.hue=='Analise Audio'",
                   source("UI_Musicas.R",local=TRUE)$value
                   
 ),
 conditionalPanel( condition = "input.hue=='Potencial de Laplace'",
                   source("UI_Laplace.R",local=TRUE)$value
                   
 ),
  # titlePanel("Old Faithful Geyser Data"),
   
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      ),
 hr(),
 print("Modelo programado por Rafael Silva Pereira, contato: r.s.p.models@gmail.com")
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
 # palavragrande=c("SIS","SIR","SEIR","Atrator de Lorentz","Andar do Bebado","Ajuste de curva","Filtro Personalizado","Oscilador Quantico","Intra Hospedeiro","Informacao Neuronios")
  
    
  
  output$Drop1 = renderUI({ 
    if(input$materias=="Fisica Teorica")
      palavragrande=c("Atrator de Lorentz","Andar do Bebado","Oscilador Quantico","Potencial de Laplace")
    else if(input$materias=="Fisica Experimental")
      palavragrande=c("Ajuste de curva","Filtro Personalizado","Propagar Erro")
    else if(input$materias=="Sistemas Complexos")
      palavragrande=c("SIS","SIR","SEIR","Intra Hospedeiro","Informacao Neuronios")
    else if(input$materias=="Data Science")
      palavragrande=c("Analise Audio")
    palavragrande=sort(palavragrande)  
    selectizeInput(inputId = "hue", label = "opcao", choices =palavragrande  )})
  
  withinhost<-eventReactive(input$ativacao,{
    a=input$a1
    b=input$remedio
    c=input$fwith
    str="./a.out"
    str=paste(str,c)
    
    str=paste(str,a)
    str=paste(str,b)
    str=paste(str,"> saida.dat")
    
    #system("gcc harmonico")
    print(str)
    system("gcc artigochromer.c -lm",intern=TRUE)
    system(str,intern=TRUE)
    hu=read.table("saida.dat")
    print(hu)
    # if(input$onda=="psi")
    helpText("Azul S vermelho R verde I")
    matplot(hu[,1]/365.0,hu[,2],type="l",xlab="x",ylab="y",col="blue")
    matplot(hu[,1]/365.0,hu[,4],type="l",xlab="x",ylab="y",col = "red",add = TRUE)
    matplot(hu[,1]/365.0,hu[,6],type="l",xlab="x",ylab="y",col="green",add = TRUE)
    #p1=qplot(hu[,1],hu[,3]/hu[,2],xlab="x",ylab = "psi",geom="line")
    #else if(input$onda=="probabilidade")
    # qplot(hu[,1],hu[,4]/hu[,2],xlab="x",ylab = "psi",geom="line")
    #  qplot(hu[,1],hu[,4]/hu[,2],xlab="x",ylab = "psi",geom="line")
    
  })
  
  
  
  Neurons<-eventReactive(input$ativacaoneuron,{
    a=input$mediagauss
    b=input$vargauss
    c=input$conectividade
    str="./a.out"
    str=paste(str,c)
    
    str=paste(str,a)
    str=paste(str,b)
    str=paste(str,"> saida.dat")
    
    #system("gcc harmonico")
    print(str)
    system("gcc main_neuron.c -lm",intern=TRUE)
    system(str,intern=TRUE)
    hu=read.table("disparos.dat")
    hua=read.table("tensao.dat")
    print(hu)
    # if(input$onda=="psi")
    p1=qplot(hu[,1],hu[,2]/200.0,xlab = "passo",ylab = "percentual de neuronios disparados")
    p2=qplot(hua[,1],hua[,2]/50.0,xlab = "passo",ylab = "tensao media em relacao ao treshhold")
    multiplot(p1,p2,cols=2)
    #helpText("Azul S vermelho R verde I")
    #matplot(hu[,1]/365.0,hu[,2],type="l",xlab="x",ylab="y",col="blue")
    #matplot(hu[,1]/365.0,hu[,4],type="l",xlab="x",ylab="y",col = "red",add = TRUE)
    #matplot(hu[,1]/365.0,hu[,6],type="l",xlab="x",ylab="y",col="green",add = TRUE)
    #p1=qplot(hu[,1],hu[,3]/hu[,2],xlab="x",ylab = "psi",geom="line")
    #else if(input$onda=="probabilidade")
    # qplot(hu[,1],hu[,4]/hu[,2],xlab="x",ylab = "psi",geom="line")
    #  qplot(hu[,1],hu[,4]/hu[,2],xlab="x",ylab = "psi",geom="line")
    
  })
  
  
  fitando= eventReactive(input$calculando, 
                                  {
                                    print("pre")
                                    
                                    inFile <- input$arqui
                                    
                                    if (is.null(inFile))
                                      return(NULL)
                                    print("pre")
                                    print(inFile$datapath)
                                    w=read.table(inFile$datapath)
                                    print("pos")
                                    #ajuste(w,input$termosmaximos)
                                    ajusteunico(w,input$termosmaximos)
                                  })
  
  
  Audios= eventReactive(input$calculandomusica, 
                         {  
                          # shiny.maxRequestSize=30*1024^2

                           print("pre")
                           
                           inFile <- input$arquimusica
                           
                           if (is.null(inFile))
                             return(NULL)
                           print("pre")
                           print(inFile$datapath)
                           w=readMP3(inFile$datapath)
                           print("pos")
                           hist(w@left,xlab = "Representacao Digital da intensidade")
                           #ajuste(w,input$termosmaximos)
                           #ajusteunico(w,input$termosmaximos)
                         })
  
  
  Propagarerro= eventReactive(input$calculandoerro, 
                         {
                        #   print("pre")
                           
                           inFile <- input$arquierro
                           
                           if (is.null(inFile))
                             return(NULL)
                           #print("pre")
                           print(inFile$datapath)
                           w=read.table(inFile$datapath)
                           #hr()
                           showNotification("Calculando")
                           
                             #print("calculando")
                           if(input$opcoeserro=="soma"){
                             coluna1=w[,1]+w[,2]
                             coluna2=w[,3]+w[,4]
                             
                           }
                          else if(input$opcoeserro=="subtracao"){
                             coluna1=w[,2]-w[,1]
                             coluna2=w[,3]+w[,4]
                             
                           }
                          else if(input$opcoeserro=="produto"){
                             coluna1=w[,2]*w[,1]
                             coluna2=w[,3]*w[,2]+w[,4]*w[,1]
                             
                           }
                          else if(input$opcoeserro=="divisao"){
                             coluna1=w[,2]/w[,1]
                             coluna2=(w[,3]*w[,2]+w[,4]*w[,1])/w[,1]^2
                             
                           }
                           colunas=data.frame(coluna1,coluna2)
                           write.table(file="saida.dat",colunas)
                           showNotification("Calculado")
                           print("Calculado")
                           #ajuste(w,input$termosmaximos)
                           #ajusteunico(w,input$termosmaximos)
                         })
  
  output$downloadErro <- downloadHandler(
    filename = function() {
      paste("saida", ".dat", sep = "")
    },
    content = function(file) {
      a=read.table("saida.dat")
      write.table(a, file, row.names = FALSE,col.names = FALSE)
    }
  )
  
  
  
  filtrar= eventReactive(input$botaofiltrado, 
                                  {
                                    inFile <- input$file1
                                    
                                    if (is.null(inFile))
                                      return(NULL)
                                    print("pre")
                                    print(inFile$datapath)
                                    w=read.table(inFile$datapath)
                                    print("pos")
                                    sinal(input$Passoskernel,w)
                                  })
  
  convoluir= eventReactive(input$conv, 
                          {
                            inFile <- input$file2
                            inf<-input$file1
                            if (is.null(inFile))
                              return(NULL)
                            if (is.null(inf))
                              return(NULL)
                            print("pre")
                            print(inFile$datapath)
                            w=read.table(inFile$datapath)
                            print("pos")
                            convolucao(w)
                          })
  
  oscilador<-reactive({
    a=input$caixa
    b=input$dxcaixa
    c=input$termos
    str="./a.out"
    str=paste(str,a)
    str=paste(str,b)
    str=paste(str,c)
    
    #system("gcc harmonico")
    print(str)
    system("gcc harmonicov1.c -lm",intern=TRUE)
    system(str,intern=TRUE)
    hu=read.table("saida.dat")
    #print(hu)
    #if(input$onda=="psi")
     p1= qplot(hu[,1],hu[,2],xlab="x",ylab = "psi",geom="line")
    #else if(input$onda=="probabilidade")
     p2= qplot(hu[,1],hu[,3],xlab="x",ylab = "psi*psi",geom="line")
    multiplot(p1,p2,cols=2)
  })
  
  laplaceheat<-eventReactive(input$botaolaplace,{
    a=input$opcaocontorno
    b=input$tensaolaplace
    c=input$aterramento
    if(a=="Capacitor")
      a=1
    else if(a=="Casca circular")
      a=2
    else if(a=="Retangulo")
      a=3
    if(c=="Sim")
      c=1
    else if(c=="Nao")
      c=0
    str="./a.out"
    str=paste(str,a)
    str=paste(str,b)
    str=paste(str,c)
    
    #system("gcc harmonico")
    print(str)
  system("gcc laplacegeral.c -lm",intern=TRUE)
    system(str,intern=TRUE)
    a=read.table("saida.dat")
    #a=read.table("heatmap.dat")
    #print(hu)
    #if(input$onda=="psi")
    #p1= qplot(hu[,1],hu[,2],xlab="x",ylab = "psi",geom="line")
    #else if(input$onda=="probabilidade")
   # p2= qplot(hu[,1],hu[,3],xlab="x",ylab = "psi*psi",geom="line")
    #multiplot(p1,p2,cols=2)
    output$distPlot<-renderPlot({
  print(ggplot(data = a, aes(x =a[,1], y = a[,2])) +
      geom_tile(aes(fill = a[,3])) + xlab("x") +ylab("y") + labs(fill="V(x,y)")) }) 
  })
  
  getData <- reactive({
    tempo=input$Passos
    funParameter <- input$rho
    corrStartDate <- input$alfa
    corrEndDate <- input$beta
    infectados<- input$infeccao
    algo=input$mu
    if(input$hue=="SIS")
      return(SIS(corrStartDate, corrEndDate, funParameter,tempo,infectados ) )
    else if(input$hue=="SIR")
      return(SIR(input$alfa1, input$beta1, input$rho1,input$Passos1,input$infeccao1 ) )
    else if(input$hue=="SEIR")
      return(SEIR(input$alfa2, input$beta2, input$rho2,input$Passos2,input$infeccao2,algo ) )
    else if(input$hue=="Atrator de Lorentz")
      return(lorentz(input$alfa3,input$beta3,input$rho3,input$Passos3))
    else if(input$hue=="Andar do Bebado")
      return (drunk(input$Probabilidade,input$Passosx,input$bebados,input$Largura) )
    else if(input$hue=="Ajuste de curva")
        return(fitando())
    else if(input$hue=="Filtro Personalizado")
    {
      filtrar()
      convoluir()
    }
    else if(input$hue=="Oscilador Quantico")
      oscilador()
    else if(input$hue=="Intra Hospedeiro")
      withinhost()
    else if(input$hue=="Informacao Neuronios")
      Neurons()
    else if(input$hue=="Propagar Erro")
      Propagarerro()
    else if(input$hue=="Analise Audio")
        Audios()
    else if(input$hue=="Potencial de Laplace")
      laplaceheat()
    })
    
#   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
 #     x    <- faithful[, 2] 
  #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
   #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
   #})
  
  output$distPlot <- renderPlot({
    getData()
    aux=read.table("dataset.dat")
    # x    <- faithful$waiting
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    #hist(x, breaks = bins, col = "#75AADB", border = "white",
    #    xlab = "Waiting time to next eruption (in mins)",
    #   main = "Histogram of waiting times")
    if(input$hue=="SIS"){
      p1=qplot(aux[,1],aux[,2],data=aux,xlab="tempo",ylab="Susceptiveis")
    p2=qplot(aux[,1],aux[,3],data=aux,xlab="Tempo",ylab="Infectados")
    #p3=qplot(aux[,2],aux[,3],data=aux,xlab="y",ylab="z")
    multiplot(p1, p2,cols=2)
    }
    
    if(input$hue=="SIR"){
      p1=qplot(aux[,1],aux[,2],data=aux,xlab="tempo",ylab="Susceptiveis")
      p2=qplot(aux[,1],aux[,3],data=aux,xlab="Tempo",ylab="Infectados")
      p3=qplot(aux[,1],aux[,4],data=aux,xlab="Tempo",ylab="Resistentes")
      #p3=qplot(aux[,2],aux[,3],data=aux,xlab="y",ylab="z")
      multiplot(p1, p2,p3,cols=2)
    }
    
    if(input$hue=="SEIR"){
      p1=qplot(aux[,1],aux[,2],data=aux,xlab="tempo",ylab="Susceptiveis")
      p2=qplot(aux[,1],aux[,3],data=aux,xlab="Tempo",ylab="Expostos")
      p3=qplot(aux[,1],aux[,4],data=aux,xlab="Tempo",ylab="Infectados")
      p4=qplot(aux[,1],aux[,5],data=aux,xlab="Tempo",ylab="Resistentes")
      #p3=qplot(aux[,2],aux[,3],data=aux,xlab="y",ylab="z",)
      multiplot(p1, p2,p3,p4,cols=2)
    }
    
    if(input$hue=="Atrator de Lorentz"){
      p1=qplot(aux[,1],aux[,2],data-aux,xlab="x",ylab="y")
      p2=qplot(aux[,1],aux[,3],data-aux,xlab="x",ylab="z")
      p3=qplot(aux[,2],aux[,3],data-aux,xlab="y",ylab="z")
      multiplot(p1,p2,p3,cols=2)
      
    }
    
    if(input$hue=="Andar do Bebado"){
      
      hist(aux[,1],xlab = "distancia andada",ylab = "numero de bebados",main = "Distribuicao dos Bebados")
      
    }
    
  })
  
}

  
  
  
  
  




# Run the application 
shinyApp(ui = ui, server = server)

