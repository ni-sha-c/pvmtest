	Omega = ;
	N_bound = 130;
	r_i = 0.5e0;
	z_i = 0.5e0;
	sigma = 0.05e0;
	N_r = 6;
	r_l = sigma/(2.e0*N_r + 1.e0);	
	N_1 = 6;
	theta = linspace(0.e0, 2*pi, N_bound);
	
	ct = cos(theta);
	st = sin(theta);

	X_c = r_i*ct;
	Y_c = r_i*st;
	Z_c = z_i*ones(1,N_bound);		
	
	r = linspace(0.e0,2.e0*r_l,N_r);
	w_x =  Omega*r.*st; 
	w_y = -Omega*r.*ct;
	
	i = 1:N_r
	N_theta = [1, 6*i];
	dphi_i = 2*pi/N_theta;
		
		
			
