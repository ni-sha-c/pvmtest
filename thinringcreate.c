#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<time.h>
#include "structdefinitionspart.h"

int main()
{

	FILE *inputfile;
	NODE *node;
	UINT i,N_bound,N;
	REAL r_bound, z_i, r_i, theta, dtheta;
	REAL gamma, dgamma;	

	N = 100;
	r_bound = 1.0e0;
	z_i = 0.5e0;	
	dtheta = 2*pi/N;
	dgamma = 1.e0/
	node = (NODE *) calloc(N,sizeof(NODE));
	
	inputfile = fopen("posalpha_thinring_b.dat", "w");
	theta = -dtheta - 0.06;
	for(i=0;i<N;i++)
	{
		theta = theta + dtheta;
		node[i].pos.x1 = r_i*cos(theta);
		node[i].pos.x2 = r_i*sin(theta);
		node[i].pos.x3 = z_i;
		fprintf(inputfile, "%lf %lf %lf %lf \n",node[i].pos.x1,
		node[i].pos.x2, node[i].pos.x3, 1.e0);
		   
	} 
	
	fclose(inputfile);
	free(node);	







}
