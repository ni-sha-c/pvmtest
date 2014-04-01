function fdelta = compute_fdelta(r1, delta)
	c1 = 3.e0/4.e0/pi;
	c2 = delta^3;
	r = r1/delta;
	fdelta = c1/c2*exp(-r.^3);
end
	
