#include "neurons.h"
main(int argc,char *argv[]){
int t;
int neuronios=200;
FILE *arq,*arq1;
srand(time(NULL));
rinitialize(time(NULL));
struct neuron *n1;
arq=fopen("disparos.dat","w");
arq1=fopen("tensao.dat","w");
n1=inicializa(atof(argv[1]),atof(argv[2]),atof(argv[3]),neuronios); //conectividade media e var da gaussiana
for(t=0;t<1000;t++)
{
n1=evolucao(n1,neuronios);
n1=normaliza(n1,neuronios);
fprintf(arq,"%d\t%d\n",t,disparos);
fprintf(arq1,"%d\t%lf\n",t,tensaomedia(n1,neuronios));
//impressaognu(n1,neuronios);
}

}
