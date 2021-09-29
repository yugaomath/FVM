function  fx =basis_ax(x, x_start, h)
%% basis value of left
z = (x-x_start)./h;
fx = (4*z-3)./h;
end