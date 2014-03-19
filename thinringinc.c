#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<time.h>
#include "structdefinitionspart.h"
/* From Abrahamovitch's handbook of mathematical functions */
REAL ellipticE(REAL m)
{
	LREAL a1,a2,a3,a4,a;
	LREAL b1,b2,b3,b4,b;
	REAL elle=0.e0, m1;
	
	a1 = 4.4325141463e-01;
	a2 = 6.260601220e-02;
	a3 = 4.757383546e-02;
	a4 = 1.736506451e-02;

	b1 = 2.4998368310e-01;
	b2 = 9.200180037e-02;
	b3 = 4.069697526e-02;
	b4 = 5.26449639e-03;
	
	m1 = 1.e0 - m;
	
	a = a1*m1 + a2*pow(m1,2.0) + a3*pow(m1,3.0) + 
		a4*pow(m1,4.0) + 1.e0;
	b =	b1*m1 + b2*pow(m1,2.0) + b3*pow(m1,3.0) + 
		b4*pow(m1,4.0) + 1.e0;
	b = b*log(1.e0/m1);
	
	elle = (REAL)(a + b);
	return elle;
  
	
		
}
REAL ellipticK(REAL m)
{
	LREAL a0,a1,a2,a3,a4,a;
	LREAL b0,b1,b2,b3,b4,b;
	REAL elle=0.e0, m1;
	
	a0 = 1.38629436112e0;	
	a1 = 9.666344259e-02;
	a2 = 3.590092383e-02;
	a3 = 3.742563713e-02;
	a4 = 1.451196212e-02;

	b0 = 5e-01;
	b1 = 1.2498593597e-01;
	b2 = 6.880248576e-02;
	b3 = 3.328355346e-02;
	b4 = 4.41787012-03;
	
	m1 = 1.e0 - m;
	
	a = a0 + a1*m1 + a2*pow(m1,2.0) + a3*pow(m1,3.0) + 
		a4*pow(m1,4.0);
	b =	b0 + b1*m1 + b2*pow(m1,2.0) + b3*pow(m1,3.0) + 
		b4*pow(m1,4.0);
	b = b*log(1.e0/m1);
	
	elle = (REAL)(a + b);
	return elle;
  
	
		
}
void Initialize(NODE **node,NODE **node_old,NODE **node_initial,
	Vector **Vel,Vector *Vel_free, Vector **Inviscid,
	Vector **Viscous,REAL *nu,
	REAL *t_initial,REAL *t_final,
	REAL *dt,REAL *sigma,int *Number_of_nodes, int *Initial_number,
	int *Number_bound,int *Vis_flag,int *Kernel){

	*Initial_number=101;
	*Number_bound=1;
	*Number_of_nodes=*Number_bound*(2*(*Initial_number)-1); 
	/*	*Number_of_nodes=(*Initial_number)*2-1; */
	/*	*Number_of_nodes=(*Initial_number);   */
	*Vis_flag=0;
	*nu=0.0;

	*t_initial=0.0;
	*dt=0.05;
	*t_final=0.05*50;
	*Kernel=1;
	*sigma=0.05;
	(*Vel_free).x1=1.0;
	(*Vel_free).x2=0;
	(*Vel_free).x3=0;

	*node    =(NODE *)  calloc(*Number_of_nodes,sizeof(NODE));
	*node_old=(NODE *)  calloc(*Number_of_nodes,sizeof(NODE));
	*node_initial=(NODE *)  calloc(*Number_of_nodes,sizeof(NODE));
	*Vel     =(Vector *)calloc(*Number_of_nodes,sizeof(Vector));
	*Inviscid=(Vector *)calloc(*Number_of_nodes,sizeof(Vector));
	*Viscous =(Vector *)calloc(*Number_of_nodes,sizeof(Vector));

	Vortex_sheet(*node,*node_old,*node_initial,0,
	*Number_of_nodes-1,*Initial_number,*Number_bound,0,*t_initial); 


}
void Vortex_sheet(NODE *node,NODE *node_old,NODE *node_initial,int start_index,int end_index, int Initial_number,int Number_bound,int Identity,REAL time){

	int i,istart,iend;
		
	if(Identity==0){
		REAL t1,t2,t3,t4;
		REAL dvolume=1.0;
		istart=0;
		iend=Number_bound*(Initial_number-1);
		for(i=istart;i<iend;i++){
			node[i].pos.x1 =  ;
			node[i].pos.x2 =  t2;
			node[i].pos.x3 =  t3;
			node[i].volume =  dvolume;
			node[i].alpha.x1  =  0.;
			node[i].alpha.x2  =  t4;
			node[i].alpha.x3  =  0.;
			node[i].theta     =  0.;
			node[i].Identity  = -1;
			node[i].ins_flag  =  0;
			node_old[i]       =  node[i];
			node_initial[i]   =  node[i];
			 }
			 fclose(fpoint);
			
			 fpoint=fopen("alpha_f_single.dat","r");
			 istart=Number_bound*(Initial_number-1);
			 iend=end_index+1;
			 for(i=istart;i<iend;i++){
			fscanf(fpoint,"%lf %lf %lf %lf\n",&t1,&t2,&t3,&t4);
			node[i].pos.x1 =  t1;
			node[i].pos.x2 =  t2;
			node[i].pos.x3 =  t3;
			node[i].volume =  dvolume;
			/*dependent on time-step*/
			node[i].alpha.x1  =  t4*0.1;
			/*dependent on time-step*/
			node[i].alpha.x2  = 0.;
			node[i].alpha.x3  = 0.;
			node[i].theta     = (REAL)(i-istart)/(REAL)(iend-1-istart);
//			node[i].theta     = (REAL)(i-istart);
//			node[i].theta     =-cos(pi*(REAL)(i-istart)/(REAL)(iend-istart-1));
			printf("%d %lf\n",i,node[i].theta);
			node[i].Identity  = Identity;
			node[i].ins_flag  = 0;
			node_old[i]       = node[i];
			node_initial[i]   = node[i];
			 }
			 fclose(fpoint);

				}else{
			int iset=Number_bound*(Initial_number-1)-1;
			 for(i=start_index;i<=end_index;i++){
			 iset++;
			 node[i]=node_initial[iset];
			 node[i].Identity=Identity;
			 node_old[i]=node[i];
				 }
			}
}
int main()
{

	int i,iter,Extra_nodes;
	int Number_of_nodes,Initial_number,Number_bound,Vis_flag,Kernel,Number_of_steps;
	REAL nu,t_initial,t_final,dt,sigma,t,Totime;
	NODE *node,*node_old,*node_initial;
	Vector *Vel,*Inviscid,*Viscous,Vel_free;
	FILE *outfile,*outfile1;
	FILE *outfile2;
	outfile1=fopen("Output","w");

	Initialize(&node,&node_old,&node_initial,&Vel,&Vel_free,&Inviscid,&Viscous,&nu,
		   &t_initial,&t_final,&dt,&sigma,&Number_of_nodes,
		   &Initial_number,&Number_bound,&Vis_flag,&Kernel);
	t=t_initial;
	iter=0;
		
	

	
		


	
	

}		
