#include <stdio.h>
#include <math.h>
#include "ranf.h"
#include "boxmuller.h"
#define dv 1.2
#define treshhold 50 //5v
struct neuron{
//neuronio precisa do potencial armazenado e de seus vizinhos e do fator de transmissão no threshhold
double V; //tensao local
int *vizinhos; //numero de vizinhos
double rho; //transmissao
int nvizinhos;

};
int disparos;

struct neuron *inicializa(double conectividade,double med,double var,int tam){
struct neuron *r1;
int copia[tam];
r1=(struct neuron *)malloc(tam*sizeof(struct neuron));
int i,j;
for(i=0;i<tam;i++){
	r1[i].vizinhos=(int *)malloc(tam*sizeof(int));
	r1[i].nvizinhos=0;
	for(j=0;j<i;j++){
		if(ranf()<conectividade)
		{
			r1[i].vizinhos[r1[i].nvizinhos]=j;
			r1[i].nvizinhos++;
		}
	}

	for(j=i+1;j<tam;j++){
		if(ranf()<conectividade)
		{
			r1[i].vizinhos[r1[i].nvizinhos]=j;
			r1[i].nvizinhos++;
		}
	} //assim inicializamos os vizinhos por um grafo  direcionado
	r1[i].V=ranf()*treshhold; //inicializa tensao
	r1[i].rho=dist(med,var);
	if(r1[i].rho<0)
		r1[i].rho=0;
	//vizinhos inicializaveis,limpeza de memoria não nescessaria inicializada para grafo  direcionado
	for(j=0;j<r1[i].nvizinhos;j++){
		copia[j]=r1[i].vizinhos[j];
	}
	free(r1[i].vizinhos);
	r1[i].vizinhos=(int *)malloc(r1[i].nvizinhos*sizeof(int));
	for(j=0;j<r1[i].nvizinhos;j++){
		r1[i].vizinhos[j]=copia[j];
	}
} 

return r1; //fim da inicializacao do sistema com o minimo de memoria alocada para este
}



struct neuron *evolucao(struct neuron *r1,int tam){
//evolução da tensao no tempo
int i,j;
disparos=0;
for(i=0;i<tam;i++){
	r1[i].V+=dv;
	if(r1[i].V >= treshhold){
		disparos++;
		r1[i].V-=(treshhold*(int)(r1[i].V/treshhold));
		for(j=0;j<r1[i].nvizinhos;j++){
			r1[ r1[i].vizinhos[j]  ].V+=r1[i].rho*treshhold;
		}

	}
}

return r1;
}

double tensaomedia(struct neuron *r1,int tam)
{
int i;
double Vmed=0;
for(i=0;i<tam;i++)
	Vmed+=r1[i].V;
Vmed=Vmed/tam;
return Vmed;
}
void impressao(struct neuron *r1,int tam){
int i;
for(i=0;i<tam;i++)
	printf("%d\t%lf\n",i,r1[i].V);

}

void impressaognu(struct neuron *r1,int tam){
int i;
puts("plot '-' u 1:2:3 lc palette");
for(i=0;i<tam;i++)
	printf("%d\t%d\t%lf\n",i/(int)sqrt(tam),i%(int)sqrt(tam),r1[i].V);
puts("e");
}


struct neuron *normaliza(struct neuron *r1,int tam){
double max;
max=r1[0].V;
int i;
double aux;
for(i=1;i<tam;i++){
	if(max<r1[i].V)
		max=r1[i].V;
}
	if(max>treshhold){
		aux=treshhold/max;
	printf("%lf\t%lf\n",aux,aux*max);
		for(i=0;i<tam;i++)
			r1[i].V=r1[i].V*aux;

	}



return r1;
}





