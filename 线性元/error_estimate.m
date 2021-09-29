function [L2_error, H1_error] = error_estimate(h, x, u)
%% numerical solution

x_int = get_integration_points(x(1:end-1), x(2:end));
V_a = basis_a(x_int, repmat(x(2:end),1,5), repmat(h,1,5));
V_b = basis_b(x_int, repmat(x(1:end-1),1,5), repmat(h,1,5));

u_num = repmat(u(1:end-1),1,5).*V_a+repmat(u(2:end),1,5).*V_b;
ux_num = repmat(u(1:end-1),1,5).*repmat(-1./h,1,5)+repmat(u(2:end),1,5).*repmat(1./h,1,5);

%%  true solution 

u_true  = fun_all(x_int, 'u');
ux_true = fun_all(x_int, 'ux');

%% L2 and H1 error

l2_error = (u_true-u_num).^2;
h1_error = (ux_true-ux_num).^2;

H1_half  = sqrt(sum(numerical_int(h, h1_error)));
L2_error = sqrt(sum(numerical_int(h, l2_error)));
H1_error = sqrt(L2_error^2+H1_half^2);

end