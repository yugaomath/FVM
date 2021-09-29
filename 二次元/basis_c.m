function  f = basis_c(x, x_start, h)
%% basis value of right
z = (x-x_start)./h;
f = (2*z-1).*z;
end