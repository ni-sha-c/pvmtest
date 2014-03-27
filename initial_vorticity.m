

	N_bound = 130;
	r_i = 0.5e0;
	z_i = 0.5e0;
	dtheta = 2*pi/N_bound;
	theta = linspace(0,2*pi-dtheta,N_bound);
	sigma = 0.05e0;	 
	posx = r_i*cos(theta);
	posy = r_i*sin(theta);
	posz = repmat(z_i,1,N_bound);
	x = repmat(posx',1,N_bound);
	y = repmat(posy',1,N_bound);
	z = repmat(posz',1,N_bound);
	x1 = repmat(posx,N_bound,1);
	y1 = repmat(posy,N_bound,1);
	z1 = repmat(posz,N_bound,1);

	X = x - x1;
	Y = y - y1;
	Z = z - z1;

	rho = sqrt(X.*X + Y.*Y + Z.*Z);
	zeta = compute_zeta(rho);

	R = repmat(r_i,N_bound,1);
	B2 = (-cos(theta))';%.*normpdf(R, 0.e0, sigma);
	B1 = (sin(theta))';%.*normpdf(R, 0.e0, sigma);
	
	Omegax = zeta\B1;
	Omegay = zeta\B2;
	
	A = [posx; posy; posz; Omegax'; Omegay'];
	infile = fopen("posalpha.dat", "w");
	fprintf(infile, "%f %f %f %f %f \n", A);       

	fclose(infile);
	
		 
	
	

