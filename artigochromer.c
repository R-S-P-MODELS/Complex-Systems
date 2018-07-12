#include <stdio.h>
#include <stdlib.h>
#include <math.h>


double q=1e-3;
double v=0.4;
double w=0.9;
double v1=0.4*0.9; //v*w
double f;
double g=0.1;
double alfa=0;
double delta=0.5;
double rho=1.0;
double kb=400.0;
double y=0.1;
double a1;
double a2=200.0;
double epislon=1.0;
double k=200.0;
double mi=0.1;
double m=3.0;
int n=3;
double dt=1e-2;
double remedio;
double pretratamento=20*365; //tempo antes de tratar
double tratamento=20*365 +180; //pretratamento+ 180
double tempototal=30*365;


double ds(double S,double I,double Sd,double R){

return ( (1.0-q)*v -(f+alfa) )*S -y*S*I +g*Sd -v*(S+R) *S/kb;

}

double dsd(double S,double Sd){

return f*S -g*Sd;

}

double dr(double S,double R,double Rd,double I){

return q*v*S + ( v1 -1*(f +delta*alfa) )*R -y*R*I +g*Rd -w*v*(S+R) *R/kb;
}

double drd(double R,double Rd){

return f*R -g*Rd;
}


double a(double omega){

return a1- ( (a1*pow(omega,m) )/(pow(a2,m) +pow(omega,m) ) );
}

double imune(double i[],double omega){
int j;
double soma;
double i1[n];
i1[0]=i[0]+ (a(omega) -epislon*(omega*i[0] )/(k+omega) -mi*i[0])*dt;
soma=i1[0];
for(j=1;j<n;j++){
	i1[j]=i[j]+( 2*epislon*(omega*i[j-1] )/(k+omega) -epislon*(omega*i[j] )/(k+omega) -mi*i[j]) *dt;
	soma+=i1[j];
}
for(j=0;j<n;j++)
	i[j]=i1[j];
return soma;
}

double imunechromer(double i[],double omega){
int j;
double soma;
double i1[n];
i[0]=i[0]+ (a(omega) -epislon*(omega*i[0] )/(k+omega) -mi*i[0])*dt;
soma=i[0];
for(j=1;j<n;j++){
	i[j]=i[j]+( 2*epislon*(omega*i[j-1] )/(k+omega) -epislon*(omega*i[j] )/(k+omega) -mi*i[j]) *dt;
	soma+=i[j];
}
//for(j=0;j<n;j++)
//	i[j]=i1[j];
return soma;
}

void tratando(){
alfa=remedio;
}

void fimtratamento(){
alfa=0;
}


double rungeS(double S,double I,double Sd,double R)
{
double k1,k2,k3,k4;
k1=ds(S,I,Sd,R);
k2=ds(S+0.5*k1,I+0.5*dt,Sd+0.5*dt,R +0.5*dt);
k3=ds(S+0.5*k2,I+0.5*dt,Sd+0.5*dt,R +0.5*dt);
k4=ds(S+k3,I+dt,Sd+dt,R +dt);
return dt*(k1/6.0 +k2/3.0 +k3/3.0 +k4/6.0);
}

double rungeSd(double S,double Sd)
{
double k1,k2,k3,k4;
k1=dsd(S,Sd);
k2=dsd(S+0.5*dt,Sd+0.5*k1);
k3=dsd(S+0.5*dt,Sd+0.5*k2);
k4=dsd(S+dt,Sd+k3);
return dt*(k1/6.0 +k2/3.0 +k3/3.0 +k4/6.0);


}
double rungerR(double S,double R,double Rd,double I) 
{
double k1,k2,k3,k4;
k1=dr(S,R,Rd,I);
k2=dr(S+0.5*dt,R+0.5*k1,Rd+0.5*dt,I +0.5*dt);
k3=dr(S+0.5*dt,R+0.5*k2,Rd+0.5*dt,I +0.5*dt);
k4=dr(S+dt,R+k3,Rd+dt,I +dt);
return dt*(k1/6.0 +k2/3.0 +k3/3.0 +k4/6.0);

}

double rungeRd(double R,double Rd){
double k1,k2,k3,k4;
k1=drd(R,Rd);
k2=drd(R+0.5*dt,Rd+0.5*k1);
k3=drd(R+0.5*dt,Rd+0.5*k2);
k4=drd(R+dt,Rd+k3);
return dt*( k1/6.0 +k2/3.0 +k3/3.0 +k4/6.0);

}
/*
double rungedI(double i[],double omega){
double k1,k2,k3,k4;
int j;
double soma;
i[0]+= (a(omega) -epislon*(omega*i[0] )/(k+omega) -mi*i[0])*dt;
soma=i[0];
for(j=1;j<n;j++){
	i[j]+=( 2*epislon*(omega*i[j-1] )/(k+omega) -epislon*(omega*i[j] )/(k+omega) -mi*i[j]) *dt;
	soma+=i[j];
}
return soma;
}
*/

main(int argc,char *argv[]){
double t;
int j;
double S,Sd,R,Rd,I,i[n];
double s,sd,r,rd;
double i1[n];
f=atof(argv[1]);
a1=atof(argv[2]);
remedio=atof(argv[3]);
// inicializacao
i[0]=1;
I=1;
S=101;
Sd=R=Rd=0;
for(j=1;j<n;j++)
	i[j]=0;
for(t=0;t<pretratamento;t+=dt){
//s=rungeS(S,I,Sd,R);
//sd=rungeSd(S,Sd);
//r=rungerR(S,R,Rd,I);
//rd=rungeRd(R,Rd);
S+=dt*ds(S,I,Sd,R);
Sd+=dt*dsd(S,Sd);
R+=dt*dr(S,R,Rd,I);
Rd+=dt*drd(R,Rd);
//printf("%lf\n",i[0]);
I=imunechromer(i,S+R);
//S+=s;
//Sd+=sd;
//R+=r;
//Rd+=rd;
if(S<=1e-3)
S=0;
//if(Sd<=1e-3)
//Sd=0;
if(R<=1e-3)
R=0;
//if(Rd<=1e-3)
//Rd=0;

printf("%lf\t%lf\t%lf\t%lf\t%lf\t%lf\n",t,S,Sd,R,Rd,I);
}
tratando();
for(t=pretratamento;t<tratamento;t+=dt){
//s=rungeS(S,I,Sd,R);
//sd=rungeSd(S,Sd);
//r=rungerR(S,R,Rd,I);
//rd=rungeRd(R,Rd);
S+=dt*ds(S,I,Sd,R);
Sd+=dt*dsd(S,Sd);
R+=dt*dr(S,R,Rd,I);
Rd+=dt*drd(R,Rd);

I=imunechromer(i,S+R);
//S+=s;
//Sd+=sd;
//R+=r;
//Rd+=rd;
if(S<=1e-3)
S=0;
//if(Sd<=1e-3)
//Sd=0;
if(R<=1e-3)
R=0;
//if(Rd<=1e-3)
//Rd=0;
printf("%lf\t%lf\t%lf\t%lf\t%lf\t%lf\n",t,S,Sd,R,Rd,I);
}
fimtratamento();
for(t=tratamento;t<tempototal;t+=dt){
//s=rungeS(S,I,Sd,R);
//sd=rungeSd(S,Sd);
//r=rungerR(S,R,Rd,I);
//rd=rungeRd(R,Rd);
S+=dt*ds(S,I,Sd,R);
Sd+=dt*dsd(S,Sd);
R+=dt*dr(S,R,Rd,I);
Rd+=dt*drd(R,Rd);

I=imunechromer(i,S+R);
//S+=s;
//Sd+=sd;
//R+=r;
//Rd+=rd;
if(S<=1e-3)
S=0;
//if(Sd<=1e-3)
//Sd=0;
if(R<=1e-3)
R=0;
//if(Rd<=1e-3)
//Rd=0;
printf("%lf\t%lf\t%lf\t%lf\t%lf\t%lf\n",t,S,Sd,R,Rd,I);
}


}
