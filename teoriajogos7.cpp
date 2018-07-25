#include "stdio.h"
#include <stdlib.h>
#include "math.h"
#include "ranf.h"

#define amax 100
#define anos 2E5
#define P   0.1
#define R   1.
#define S   0.0
#define L   100
#define K   0.1
#define mu 1./amax
#define pi acos(-1.0)
#define amed 50
int main(int argc, char *argv[]){
    //float mu = 1./amax;
    int i,j,k;
//    for (i=0; i< amax; i++)
//        printf("%d %lf\n",i, exp(-1.*pow(i-amed,2)/(2*sigma*sigma)));
        
        
    //printf("%d\n", mu);
    int N=L*L;
    float T=atof(argv[2]);
    float sigma=atof(argv[3]);
    float payoff[4],  sorteio;
    double pii, pij,w;
    payoff[0]=P;
    payoff[1]=T;
    payoff[2]=S;
    payoff[3]=R;
    
    int nn,vizi;
    int cont[2];
    cont[0]=cont[1]=0;
    int *idade;
    int *comportamento;
    idade=(int *) malloc (N*sizeof(int));
    comportamento=(int *) malloc (N*sizeof(int));
    
    rinitialize(atoi(argv[1]));
    
    //////////////////////////////////////////////////
    // Cria a rede atribuindo idade e comportamento
    //////////////////////////////////////////////////
    for(i=0;i<N;i++){
            idade[i] = amax/2*ranf();

            if(ranf()>0.5){
                comportamento[i]=0;
                cont[0]++;
            }else{
                comportamento[i]=1;
                cont[1]++;
            }
    }

    ///////////////////////////////////////////
    // Inicia a dinamica
    ///////////////////////////////////////////
    for(k=0;k<anos;k++){
        for(i=0;i<N;i++){
            j=N*ranf();
            ///////////////////////////////////////
            // Calcula Pi_i
            ///////////////////////////////////////
            pii=0;
            if ((nn=j+1)%L==0)nn-=L;
            pii+=payoff[comportamento[j]*2+comportamento[nn]];
            nn=j-1;
            if(j%L==0)nn+=L;
            pii+=payoff[comportamento[j]*2+comportamento[nn]];
            if((nn=j+L)>=N)nn-=N;
            pii+=payoff[comportamento[j]*2+comportamento[nn]];
            if ((nn=j-L)<0)nn+=N;
            pii+=payoff[comportamento[j]*2+comportamento[nn]];
            ////////////////////////////////////////////////////////
            // Sortear um vizinho
            ////////////////////////////////////////////////////////
            sorteio=ranf();
            if(sorteio<0.5){
                if(sorteio<0.25){
                    if((vizi=j+1)%L==0)vizi-=L;
                }else{
                    vizi=j-1;
                    if(j%L==0)vizi+=L;
                }
            }else{
                if(sorteio<0.75){
                    if((vizi=j+L)>=N)vizi-=N;
                }else{
                    if((vizi=j-L)<0)vizi+=N;
                }
            }
            /////////////////////////////////////////////////////////
            //Calcula Pi_j
            /////////////////////////////////////////////////////////
            pij=0;
            if ((nn=vizi+1)%L==0)nn-=L;
            pij+=payoff[comportamento[vizi]*2+comportamento[nn]];
            nn=vizi-1;
            if(vizi%L==0)nn+=L;
            pij+=payoff[comportamento[vizi]*2+comportamento[nn]];
            if((nn=vizi+L)>=N)nn-=N;
            pij+=payoff[comportamento[vizi]*2+comportamento[nn]];
            if ((nn=vizi-L)<0)nn+=N;
            pij+=payoff[comportamento[vizi]*2+comportamento[nn]];

            /////////////////////////////////////////////////////////////////////
            //normaliza pi
            ////////////////////////////////////////////////////////////////////
            pii=pii*exp(-1.*pow(idade[j]-amed,2)/(2*sigma*sigma));
            pij=pij*exp(-1.*pow(idade[vizi]-amed,2)/(2*sigma*sigma));
            //////////////////////////////////////////////////
            //calcular w
            ////////////////////////////////////////
            w=1./(1.+exp((double)(pii-pij)/K)); 
            if(ranf()<w){
                cont[comportamento[j]]--;
                comportamento[j]=comportamento[vizi];
                cont[comportamento[j]]++;
            }
        }
        for(i=0;i<N;i++){
            if(ranf()<mu){
                idade[i]=0;
            }else{
                idade[i]++;
            }
        }
//        wa=wa^1;
//        wd=wd^1;
        printf("%d %.8f %.8f\n",k,(float)cont[0]/N,(float)cont[1]/N);     
        if( cont[0]==N || cont[1]==N) k=2*anos;
    
    }
        
        
        
    return 0;
}
