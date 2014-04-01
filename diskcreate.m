	Omega = 0.5e0; %stands for the Omega from Norbury's paper
	N_bound = 120;
	r_i = 1.e0;
	z_i = 0.5e0;
	sigma = 0.275e0;
	N_r = 3;
	r_l = sigma/(2.e0*N_r + 1.e0);
	delta = 0.155;	
	N_1 = 6;
	N_per_theta = 1 + N_1*N_r*(N_r + 1)/2;
	dtheta = 2.e0*pi/N_bound;
	theta = linspace(0.e0 , 2.e0*pi - dtheta, N_bound);
	
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

	outliner = 2.e0*r_l*outline1;
	outlinep = 2.e0*pi/N_1*outline2;		
	r_c = repmat(outliner, N_per_theta,1);
	r_ct= r_c';
	phi = repmat(outlinep, N_per_theta, 1);
	phi_t = phi';

	cp = cos(phi);
	sp = sin(phi);
	rcp = r_c.*cp;
	rsp = r_c.*sp;
	rccp = outliner.*cos(outlinep);
	rcsp = outliner.*sin(outlinep);

	%theta = 0
	X = rsp' + r_i;
	Y = repmat(0.e0,N_per_theta,N_per_theta);
	Z = rcp' + z_i;

	Fdelta = zeros(N_per_theta,N_per_theta);

	for j = 1:N_bound
		tj = theta(j);
		ctj = cos(tj);
		stj = sin(tj);
		
		Xj = ctj*rsp + r_i*ctj;
		Yj = stj*rsp + r_i*stj;
		Zj =     rcp + z_i    ;

		XmXj = X - Xj;
		YmYj = Y - Yj;
		ZmZj = Z - Zj;

		mag2xmxj = XmXj.*XmXj + YmYj.*YmYj + ZmZj.*ZmZj;
		magxmxj  = sqrt(mag2xmxj);

		Fdelta = Fdelta + compute_zeta(magxmxj,delta);

	end

	deltaxi = 2.e0*pi/N_bound*(rcp + r_i);
	F_delta = deltaxi.*Fdelta;

%	r2 =	outliner.*outliner + r_i*r_i + 2.e0*r_i*outliner.*sp;
%	w = Omega*sqrt(r2);
	w = compute_omega(outliner,sigma);
	gamma = F_delta\w';
	alpha = gamma'.*deltaxi(1,:);

	
	Zpos = [];
	Xpos = [];
	Ypos = [];
	A1 = [];
	A2 = [];
	for j = 1:N_bound
		th =  (j-1)*dtheta;
		sth = sin(th);
		cth = cos(th);
		xc = repmat(X_c(j), 1, N_per_theta);
		yc = repmat(Y_c(j), 1, N_per_theta);
		zc = repmat(Z_c(j), 1, N_per_theta);
		Zpos = [ Zpos , zc + rccp ];
		Ypos = [ Ypos , yc + sth*rcsp];
		Xpos = [ Xpos , xc + cth*rcsp];
		A1 = [ A1, -sth*alpha];
		A2 = [ A2, cth*alpha];
	end
	
	infile = fopen("posalpha_norbury_during_run.dat", "w");
	RES = [Xpos; Ypos; Zpos; A1; A2];
	fprintf(infile, " %8.6f %8.6f %8.6f %8.6f %8.6f \n", RES);

	fclose(infile);

	 

	 	
		
						  		


				
			
		
		 	
			
