function  fx = basis_bx(x, x_start, h)
%% basis value of middle
z = (x-x_start)./h;
fx = (-8*z+4)./h;
end