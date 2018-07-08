#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
packages <- c("ggplot2","shiny")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

require(shiny)
require(ggplot2)
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
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
  print(summary(fit2))
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
  div(style="display:inline-block",selectInput(inputId = "hue",label="opcao",choices = c("SIS","SIR","SEIR","Atrator de Lorentz","Andar do Bebado","Ajuste de curva") ) ),      
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
  

  # titlePanel("Old Faithful Geyser Data"),
   
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
  fitando= eventReactive(input$calculando, 
                                  {
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

