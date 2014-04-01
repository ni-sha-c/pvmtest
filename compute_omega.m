function omega = compute_omega(r1,sigma)
		r = r1/sigma;
		r3 = -r.^3;
		omega = exp(r3)/sigma/sigma;
		omega = 3.e0/pi/1.35413*omega;

