function  fx = basis_cx(x, x_start, h)
%% basis value of right
z = (x-x_start)./h;
fx = (4*z-1)./h;
end