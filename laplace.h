#include <string.h>
#define l 100
#define n l*l
#define v 100
#define dx 2.0/l
#define expessura 0.3*l
#define inicial 1.0
#define precisao 1e-5
#define distancia 0.4*l
#define raio_1 0.3*n/4
#define raio_2 0.5*n/4
#define abertu 0.05*l
#define tol_R 0.5*l
#define pulo 10
#define analise 0
#define barreira 1 //apenas as areas com tag analise devem ser evoluidas

void funcoes(){
char a[50];

do{
printf("\nAs funcoes disponiveis nesta biblioteca são respectivamente:\n\naterramento\nplaca_paralela_y\nplaca_paralela_x\npotencial_central\ncasca_circular\ninicializacao\ncopia\n\npara ver como utilizar uma funcao especifica favor digitar o nome dela exatamente como citado\npara sair digite sair\n\n");
gets(a);
if(!strcmp(a,"sair"))
	puts("saindo");
else if(!strcmp(a,"aterramento"))
printf("a funcao aterramento deve ser chamada como aterramento(m,tags,size_x,size_y) onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz,ao ser executada esta função fixara todos os pontos de fronteira como 0 volts por toda a simulação,ela deve ser a ultima funcao a ser executada na criacao das barreiras\n");
else if(!strcmp(a,"placa_paralela_y"))
printf("a funcao placa_paralela_y cria um capacitor paralelo ao eixo y,esta deve ser chamada como placa_paralela_y(m,tags,size_x,size_y,distancia_centro,potencial onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz,distancia_centro é a distancia que ambas as placas do capacitor ficaram do centro da matriz,este valor é um percentual da largura da matriz,por exemplo se passar como parametro 0.1 ambas as placas se distanciaram 10 por cento do tamanho da rede do centro portanto deve ser limitado a 0.5,potencial é o valor do potencial \n");
else if(!strcmp(a,"placa_paralela_x"))
printf("a funcao placa_paralela_x cria um capacitor paralelo ao eixo x,esta deve ser chamada como placa_paralela_x(m,tags,size_x,size_y,distancia_centro,potencial onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz,distancia_centro é a distancia que ambas as placas do capacitor ficaram do centro da matriz,este valor é um percentual da largura da matriz,por exemplo se passar como parametro 0.1 ambas as placas se distanciaram 10 por cento do tamanho da rede do centro portanto deve ser limitado a 0.5,potencial é o valor do potencial \n");
else if(!strcmp(a,"potencial_central"))
puts("a funcao potencial_central cria um potencial retangular de largura definida por input,deve ser chamado por potencial_central(m,tags, size_x,size_y,distancia_x,distancia_y,potencial),onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz,distancia_x e distancia_y respectivamente as larguras do retangulo de potencial e potencial o potencial,as distancias são percentuais da largura da matriz entre 0 para nada até 1 para 100 por cento)");

else if(!strcmp(a,"casca_circular") )
puts("a funcao casca_circular cria um circulo com potencial constante de raio definido por input,deve ser chamado por casca_circular(m,tags,size_x,size_y,raio,potencial,abertura) onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz,raio  o raio do circulo em relação a rede,potencial o potencial do circulo e abertura o quanto do circulo ira abrir no eixo x (este valor deve ser bem pequeno não ultrapassando 0.05*l )");

else if(!strcmp(a,"inicializacao") )
printf("a funcao inicializacao ira inicializar a matriz de calculo e sua matriz de adjacencia,a inicie como inicializacao(m,tags,size_x,size_y) onde m é a matriz do seu sistema tags é a matriz de adjacencia usada para localizar os pontos de barreira,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz\n");

else if(!strcmp(a,"copia") )
printf("A funcao copia ira gerar uma copia da matriz de trabalho para ser utilizada com metodos que utilizem o conceito de estado futuro ,deve ser chamada como copia(m,m1,size_x,size_y) onde m é a matriz do seu sistema m1 a matriz que recebera a copia,size_x o tamanho do eixo x da sua matriz e size_y o tamanho do eixo y da matriz \n");
else
puts("opcao invalida");


}while(strcmp(a,"sair")!=0 );

}

double aterramento(double **m,double **tags,int size_x,int size_y){
int i,j;
int contador=0;
i=0;
for(j=0;j<size_y;j++){
	m[i][j]=0;
	tags[i][j]=barreira;
	contador++;
	}
i=size_x-1;
for(j=0;j<size_y;j++){
	m[i][j]=0;
	tags[i][j]=barreira;
	contador++;
	}
i=0;
for(j=0;j<size_x;j++){
	m[j][i]=0;
	tags[j][i]=barreira;
	contador++;
	}
i=size_y-1;
for(j=0;j<size_x;j++){
	m[j][i]=0;
	tags[j][i]=barreira;
	contador++;
	}
return contador;
}

double placa_paralela_y(double **m,double **tags,int size_x,int size_y,int distancia_centro,double potencial){
int i,j,contador=0;
i=size_x/2-distancia_centro;
for(j=0;j<size_y;j++){
	m[i][j]=-potencial;
	tags[i][j]=barreira;
	contador++;
}

i=size_x/2+distancia_centro;
for(j=0;j<size_y;j++){
	m[i][j]=potencial;
	tags[i][j]=barreira;
	contador++;
}
return contador;
}

double placa_paralela_x(double **m,double **tags,int size_x,int size_y,int distancia_centro,double potencial){
int i,j,contador=0;
j=size_y/2-distancia_centro;
for(i=0;i<size_y;i++){
	m[i][j]=-potencial;
	tags[i][j]=barreira;
	contador++;
}

j=size_x/2+distancia_centro;
for(i=0;i<size_y;i++){
	m[i][j]=potencial;
	tags[i][j]=barreira;
	contador++;
}
return contador;
}

double potencial_central(double **m,double **tags,int size_x,int size_y,int distancia_x,int distancia_y,double potencial){
int i,j,contador=0;
for(i=size_x/2-distancia_x/2;i<size_x/2+distancia_x/2;i++){
	for(j=size_y/2-distancia_y/2;j<size_y/2+distancia_y/2;j++){
		m[i][j]=potencial;
		tags[i][j]=barreira;
		contador++;
	}
}

return contador;
}


double fio_central(double **m,double **tags,int size_x,int size_y,int distancia_x,int distancia_y,double potencial){
int i,j,contador=0;
i=size_x/2-distancia_x/2;
//for(i=size_x/2-distancia_x/2;i<size_x/2+distancia_x/2;i++){
	for(j=size_y/2-distancia_y/2;j<size_y/2+distancia_y/2;j++){
		m[i][j]=potencial;
		tags[i][j]=barreira;
		contador++;
	}
i=size_x/2+distancia_x/2;
//for(i=size_x/2-distancia_x/2;i<size_x/2+distancia_x/2;i++){
	for(j=size_y/2-distancia_y/2;j<size_y/2+distancia_y/2;j++){
		m[i][j]=potencial;
		tags[i][j]=barreira;
		contador++;
	}

j=size_y/2-distancia_y/2;
for(i=size_x/2-distancia_x/2;i<size_x/2+distancia_x/2;i++){
	
		m[i][j]=potencial;
		tags[i][j]=barreira;
		contador++;
	}
j=size_y/2+distancia_y/2;
for(i=size_x/2-distancia_x/2;i<size_x/2+distancia_x/2;i++){
	
		m[i][j]=potencial;
		tags[i][j]=barreira;
		contador++;
	}

return contador;
}


double casca_circular(double **m,double **tags,int size_x,int size_y,double raio,double potencial,int abertura)
{
int i,j,contador=0;
double conta;
for(i=1;i<size_x;i++){
	for(j=1;j<size_y;j++){
		if( fabs(j-size_y/2)>abertura ){
		conta=pow( (i-size_x/2),2) +pow( (j-size_y/2),2);
		if( (raio-tol_R<conta)&&(raio+tol_R>conta) ) {
			tags[i][j]=barreira;
			m[i][j]=potencial;
			contador++;
		}
		
		
		
	}
	}

}


return contador;
}

void inicializacao(double **m,double **tags,int size_x,int size_y){
int i,j;
for(i=0;i<size_x;i++){
	for(j=0;j<size_y;j++){
		m[i][j]=inicial;
		tags[i][j]=analise;

	}

}


}

void copia(double **m,double **m1,int size_x,int size_y){
int i,j;
	for(i=0;i<size_x;i++){
		for(j=0;j<size_y;j++){
			m1[i][j]=m[i][j];
		}
	}
}

//obs aterre apenas ao fim das barreiras

