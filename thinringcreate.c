#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<time.h>
#include "structdefinitionspart.h"

int main()
{

	FILE *inputfile;
	NODE *node;
	UINT i,N;
	REAL r_i, z_i, theta, dtheta;

	N = 100;
	r_i = 0.5e0;
	z_i = 0.5e0;	
	dtheta = 2*pi/N;
	node = (NODE *) calloc(N,sizeof(NODE));
	
	inputfile = fopen("posalpha_thinring.dat", "w");
	theta = -dtheta;
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
