#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include "laplace.h"
#define escala dx

main(int argc,char *argv[]){
//double m[l+2][l+2],mf[l+2][l+2]; // 0 e l+1 é borda
FILE *arquivo,*saidalap;
double **m,**mf;
double **Ex,**Ey;
double **tags;
int *pontos,tamanho;
int i,j,k,conta,contador;
double maximo,media;
int circulos,central,capacitoresx,capacitoresy;
double infopot;
double cordenada; //infopot vai ser usada p armazenar potencial cordenada vai armazenar a distancia ou tamanho do central/valor do raio etc
int trigger; //trigger ira verificar se ocorreu aterramento ou não pois o loop pode ser mais eficiente se for aterrado
int numero=0;
i=0;
m=(double **)malloc( (l+2)*sizeof(double *) );
mf=(double **)malloc( (l+2)*sizeof(double *) );
tags=(double **)malloc( (l+2)*sizeof(double *) );
Ex=(double **)malloc( (l+2)*sizeof(double *) );
Ey=(double **)malloc( (l+2)*sizeof(double *) );
for(i=0;i<l+2;i++){
m[i]=(double *)malloc( (l+2)*sizeof(double) );
mf[i]=(double *)malloc( (l+2)*sizeof(double) );
tags[i]=(double *)malloc( (l+2)*sizeof(double) );
Ex[i]=(double *)malloc( (l+2)*sizeof(double) );
Ey[i]=(double *)malloc( (l+2)*sizeof(double) );
}
arquivo=fopen("output.plot","w");
saidalap=fopen("saida.dat","w");
contador=0;
inicializacao(m,tags,l+2,l+2);
int opcaocontorno=atoi(argv[1]);
infopot=atof(argv[2]);
int aterra=atoi(argv[3]);
if(opcaocontorno==1)
	contador+=placa_paralela_x(m,tags,l+2,l+2,0.3*l,infopot);
else if(opcaocontorno==2)
	contador+=casca_circular(m,tags,l+2,l+2,0.3*n/4,infopot,abertu); 
else if(opcaocontorno==3)
	contador+=potencial_central(m,tags,l+2,l+2,0.3*(l+2),0.3*(l+2),infopot);
if(aterra==1){
	contador+=aterramento(m,tags,l+2,l+2);
	trigger=1;
}
else if(aterra==0)
	trigger=0;	
//criação das barreiras
/*
puts("quantos circulos deseja criar");
scanf("%d",&circulos);
puts("quantos capacitores no eixo x deseja criar");
scanf("%d",&capacitoresx);
puts("quantos capacitores no eixo y deseja criar");
scanf("%d",&capacitoresy);
puts("deseja um potencial central ou fio central? digite 1 para potencial 2 para fio  0 nenhum");
scanf("%d",&central);
for(i=0;i<circulos;i++){
printf("digite o raio do circulo  %d como um valor de 0 a 1\n",i);
scanf("%lf",&cordenada);
printf("digite o potencial do circulo %d\n",i);
scanf("%lf",&infopot);
contador+=casca_circular(m,tags,l+2,l+2,cordenada*n/4,infopot,abertu); 
}

for(i=0;i<capacitoresx;i++){
printf("digite a distancia do centro do capacitor em x  %d como um valor de 0 a 0.5\n",i);
scanf("%lf",&cordenada);
printf("digite o potencial do capacitor %d\n",i);
scanf("%lf",&infopot);
contador+=placa_paralela_x(m,tags,l+2,l+2,cordenada*l,infopot); 
}

for(i=0;i<capacitoresy;i++){
printf("digite a distancia do centro do capacitor em y  %d como um valor de 0 a 0.5\n",i);
scanf("%lf",&cordenada);
printf("digite o potencial do capacitor %d\n",i);
scanf("%lf",&infopot);
contador+=placa_paralela_y(m,tags,l+2,l+2,cordenada*l,infopot); 
}

if(central==1){
printf("digite o tamanho do potencial central como um valor de 0 a 1\n");
scanf("%lf",&cordenada);
printf("digite o potencial\n");
scanf("%lf",&infopot);
contador+=potencial_central(m,tags,l+2,l+2,cordenada*(l+2),cordenada*(l+2),infopot);

}
if(central==2){
printf("digite a largura do fio central como um valor de 0 a 1\n");
scanf("%lf",&cordenada);
printf("digite o potencial\n");
scanf("%lf",&infopot);
contador+=fio_central(m,tags,l+2,l+2,cordenada*(l+2),cordenada*(l+2),infopot);

}
//contador+=casca_circular(m,tags,l+2,l+2,raio_1,-v,abertu);
//contador+=casca_circular(m,tags,l+2,l+2,raio_2,+v,abertu);
//contador+=potencial_central(m,tags,l+2,l+2,0.1*(l+2),0.1*(l+2),v);
//contador+=placa_paralela_y(m,tags,l+2,l+2,0.3*l,v);
//contador+=placa_paralela_x(m,tags,l+2,l+2,0.3*l,v);
puts("deseja aterrar digite 1 para sim 0 para não");
scanf("%lf",&infopot);
if(infopot==1){
contador+=aterramento(m,tags,l+2,l+2);
trigger=1;
}
else
trigger=0;
*/
pontos=(int *)malloc( ( (l+2)*(l+2)-contador)*sizeof(int) );
tamanho=(l+2)*(l+2)-contador;
//printf("%d\n",tamanho);
contador=0;
for(i=0;i<l+2;i++){
	for(j=0;j<l+2;j++){
		if(tags[i][j]!=barreira){
			pontos[contador]=i*(l+2)+j;
		//	printf("%d\t%d\t%d\t%d\n",i,j,pontos[contador],contador);
			//printf("%d\t%d\t%d\t%d\t%d\n",i,j,pontos[contador]/(l+2),pontos[contador]%(l+2),pontos[contador] );
			contador++;
		}
	}
} //ver pq 0 0 da falha de segmentacao
//fim do prenchimento,inicio da copia
//puts("copiar");
copia(m,mf,l+2,l+2);
fprintf(arquivo,"set xrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set yrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set term png\n");
fprintf(arquivo,"set output 'output inicial.png'\n");
fprintf(arquivo,"plot '-' u 1:2:3 lc palette notitle\n");
for(i=0;i<l+2;i++){
	for(j=0;j<l+2;j++){
		//m[i][j]=mf[i][j];
		
		fprintf(arquivo,"%lf\t%lf\t%lf\n",i*dx,j*dx,m[i][j]);
}
fprintf(arquivo,"\n");

}
fprintf(arquivo,"e\n");

for(i=1;i<l+1;i++){
	for(j=1;j<l+1;j++){
	Ex[i][j]=(m[i][j]-m[i-1][j])/dx;
	Ey[i][j]=(m[i][j]-m[i][j-1])/dx;	
	}
}
/*
fprintf(arquivo,"set term x11\n");
fprintf(arquivo,"set xrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set yrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set term png\n");
fprintf(arquivo,"set output 'campo eletrico inicial.png'\n");
fprintf(arquivo,"plot '-' u 1:2:3:4 with vectors notitle\n");
for(i=1;i<l+1;i++){
	for(j=1;j<l+1;j++){
		//m[i][j]=mf[i][j];
		
		fprintf(arquivo,"%lf\t%lf\t%lf\n",i*dx,j*dx,Ex[i][j],Ey[i][j]);
}
fprintf(arquivo,"\n");

}
fprintf(arquivo,"e\n");*/
//puts("pause 10");
//inicio do loop
contador=0;
//puts("antes do");
if(trigger==1){
	do{
		contador++;
		maximo=-1;
		media=0;
		//l/2-round(distancia)
		for(i=1;i<l+1;i++){
			for(j=1;j<l+1;j++){
				media+=m[i][j];
				}

			}
		//puts("pre pontos");
		for(k=0;k<tamanho;k++){
		i=pontos[k]/(l+2);
		j=pontos[k]%(l+2);
		mf[i][j]=0.25*(m[i+1][j]+m[i-1][j]+m[i][j+1]+m[i][j-1]);
		if(fabs(mf[i][j]-m[i][j] )>maximo )
					maximo=fabs(mf[i][j]-m[i][j] );
		}

		for(i=0;i<l+2;i++){
			for(j=0;j<l+2;j++){
				m[i][j]=mf[i][j];
		}
		}
		//printf("%d\n",contador);	
			
	}
while(maximo>precisao);
}
else{
	do{
		contador++;
		maximo=-1;
		media=0;
		//l/2-round(distancia)
		for(i=0;i<l+2;i++){
			for(j=0;j<l+2;j++){
				media+=m[i][j];
				}

			}
//		puts("pre pontos");
		for(k=0;k<tamanho;k++){
		i=pontos[k]/(l+2);
		j=pontos[k]%(l+2);
		if(i==0&&j==0){
			mf[i][j]=0.5*(m[i+1][j]+m[i][j+1]);
			
		}
		else if(i==l+1&&j==l+1){
			mf[i][j]=0.5*(m[i-1][j]+m[i][j-1]);
			//puts("aqui foi");
		}
		else if(i==0&&j==l+1){
			mf[i][j]=0.5*(m[i+1][j]+m[i][j-1]);
			//puts("aqui tambem");
		}
		else if(i==l+1&&j==0)
			mf[i][j]=0.5*(m[i-1][j]+m[i][j+1]);
		else if(i==0)
			mf[i][j]=0.33*(m[i+1][j]+m[i][j-1]+m[i][j+1] );
		else if(i==l+1){
			mf[i][j]=0.33*(m[i-1][j]+m[i][j-1]+m[i][j+1] );
			//puts("aqui tambem");
		}
		else if(j==0)
			mf[i][j]=0.33*(m[i+1][j]+m[i-1][j]+m[i][j+1] );
		else if(j==l+1)
			mf[i][j]=0.33*(m[i-1][j]+m[i][j-1]+m[i+1][j] );
		else	
			mf[i][j]=0.25*(m[i+1][j]+m[i-1][j]+m[i][j+1]+m[i][j-1]);
	
		if(fabs(mf[i][j]-m[i][j] )>maximo )
					maximo=fabs(mf[i][j]-m[i][j] );
		}

		for(i=0;i<l+2;i++){
			for(j=0;j<l+2;j++){
				m[i][j]=mf[i][j];
		}
		}
		//printf("%d\n",contador);		
	}
	while(maximo>precisao);

}
printf("%d\n",contador);
//puts("cabou");
//fim do calculo,calculo do campo eletrico
for(i=1;i<l+1;i++){
	for(j=1;j<l+1;j++){
	Ex[i][j]=-(m[i][j]-m[i-1][j])/dx;
	Ey[i][j]=-(m[i][j]-m[i][j-1])/dx;	
	}
}
media=media/(l*l);
fprintf(arquivo,"set term x11\n");
fprintf(arquivo,"set term png\n");
fprintf(arquivo,"set output 'output final 2d.png'\n");
fprintf(arquivo,"set xrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set yrange[0:%lf]\n",(l+2)*dx );
fprintf(arquivo,"set title 'potencial medio %lf\t maximo variado %lf\n",media,maximo);
fprintf(arquivo,"plot '-' u 1:2:3 lc palette notitle\n");
for(i=0;i<l+2;i++){
	for(j=0;j<l+2;j++){
		//m[i][j]=mf[i][j];
		
		fprintf(arquivo,"%lf\t%lf\t%lf\n",i*dx,j*dx,m[i][j]);
		fprintf(saidalap,"%lf\t%lf\t%lf\n",i*dx,j*dx,m[i][j]);
}
fprintf(arquivo,"\n");

}
fprintf(arquivo,"e\n");

fprintf(arquivo,"set term x11\n");
fprintf(arquivo,"set term png\n");
fprintf(arquivo,"set output 'campo eletrico final 2d.png'\n");
fprintf(arquivo,"set xrange[0:%lf]\n",(l)*dx);
fprintf(arquivo,"set yrange[0:%lf]\n",(l)*dx);
fprintf(arquivo,"set title 'potencial medio %lf\t maximo variado %lf\n",media,maximo);
fprintf(arquivo,"plot '-' u 1:2:3:4:5 with vectors lc palette notitle\n");
for(i=1;i<l+1;i++){
	for(j=1;j<l+1;j++){
		//m[i][j]=mf[i][j];
		
		fprintf(arquivo,"%lf\t%lf\t%lf\t%lf\t%lf\n",i*dx,j*dx,escala*Ex[i][j]/sqrt(pow(Ex[i][j],2)+pow(Ey[i][j],2) ),escala*Ey[i][j]/sqrt(pow(Ex[i][j],2)+pow(Ey[i][j],2) ),sqrt(pow(Ex[i][j],2)+pow(Ey[i][j],2) ) );
}
fprintf(arquivo,"\n");

}
fprintf(arquivo,"e\n");

fprintf(arquivo,"set term x11\n");
fprintf(arquivo,"set pm3d\n");
fprintf(arquivo,"set term png\n");
fprintf(arquivo,"set output 'output final 3d.png'\n");
fprintf(arquivo,"set xrange[0:%lf]\n",(l+2)*dx);
fprintf(arquivo,"set yrange[0:%lf]\n",(l+2)*dx );
fprintf(arquivo,"set title 'potencial medio %lf\t maximo variado %lf\n",media,maximo);
fprintf(arquivo,"splot '-' u 1:2:3 notitle\n");
for(i=0;i<l+2;i++){
	for(j=0;j<l+2;j++){
		//m[i][j]=mf[i][j];
		
		fprintf(arquivo,"%lf\t%lf\t%lf\n",i*dx,j*dx,m[i][j]);
}
fprintf(arquivo,"\n");

}
fprintf(arquivo,"e\n");
puts("arquivos gerados output inicial.png campo eletrico inicial.png output final 2d.png campo eletrico final 2d.png output final 3d.png");
}

