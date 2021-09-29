function  f =basis_a(x, x_start, h)
%% basis value of left
z = (x-x_start)./h;
f = (2*z-1).*(z-1);
end