function  f = basis_b(x, x_start, h)
%% basis value of middle
z = (x-x_start)./h;
f = 4*z.*(1-z);
end