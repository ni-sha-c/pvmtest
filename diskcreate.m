	Omega = 0.5e0; %stands for the Omega from Norbury's paper
	N_bound = 120;
	r_i = 0.5e0;
	z_i = 0.5e0;
	sigma = 0.275e0;
	N_r = 3;
	r_l = sigma/(2.e0*N_r + 1.e0);
	delta = 0.155;	
	N_1 = 6;
	N_per_theta = 1 + N_1*N_r*(N_r + 1)/2;
	dtheta = 2.e0*pi/N_bound;
	theta = linspace(dtheta/2.e0, 2.e0*pi-dtheta/2.e0, N_bound);

	
	ct = cos(theta);
	st = sin(theta);

	X_c = r_i*ct;
	Y_c = r_i*st;
	Z_c = z_i*ones(1,N_bound);		
	
	%r = linspace(0.e0,N_r*2.e0*r_l,N_r+1);
	%w_x =  Omega*r.*st; 
	%w_y = -Omega*r.*ct;
	
	i = 1:N_r;
	N_theta = [1, N_1*i];
	
	l = 2;
	count = 0;
	outline1(1) = 0;
	outline2(1) = 0;	
	for k = 2:N_per_theta
		if(mod(k,6)==2 && k > sum(N_theta(1:l),2))
			l = l + 1;
			count = 0;
		end 
		outline1(k) = l-1;
		outline2(k) = 1.e0/(l-1)*count;
		count = count + 1;
	end
		
	r_c = repmat(2.e0*r_l*outline1, N_per_theta,1);
	r_ct= r_c';
	phi = repmat(pi/N_1*outline2, N_per_theta, 1);
	phi_t = phi';
	w = 2.e0*r_l*Omega*outline1;

	magxmxi = r_c.*r_c + r_ct.*r_ct - 2.e0*(r_c.*r_ct).*(cos(phi-phi_t));
	F_delta = compute_zeta(magxmxi,delta);
	alpha = F_delta\w';

	cp = cos(pi/N_1*outline2);
	sp = sin(pi/N_1*outline2);
	rcp = 2.e0*r_l*outline1.*cp;
	rsp = 2.e0*r_l*outline1.*sp;
	
	Z = [];
	X = [];
	Y = [];
	A1 = [];
	A2 = [];
	for j = 1:N_bound
		th = dtheta/2.e0 + (j-1)*dtheta;
		sth = sin(th);
		cth = cos(th);
		xc = repmat(X_c(j), N_per_theta, 1);
		yc = repmat(Y_c(j), N_per_theta, 1);
		zc = repmat(Z_c(j), N_per_theta, 1);
		Z = [ Z , zc + rcp ];
		Y = [ Y , sth*rsp];
		X = [ X , cth*rsp];
		A1 = [ A1, sth*alpha'];
		A2 = [ A2, -cth*alpha'];
	end
	
	infile = fopen("posalpha_norbury_b.dat", "w");
	RES = [X', Y', Z', A1', A2'];
	fprintf(infile, " %8.6f %f %f %f %f \n", RES);

	fclose(infile);

	 

	 	
		
						  		


				
			
		
		 	
			
