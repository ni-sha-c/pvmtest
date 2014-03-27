function res = compute_zeta(x) 
	delta = 5.e-2;
	y = x/delta;
	c1 = 7.5e0/4.e0/pi/delta^3;
	den = (1 + y.*y).^(3.5e0);
	res = c1./den;
endfunction
