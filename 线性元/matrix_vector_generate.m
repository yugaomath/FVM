function [A, F] = matrix_vector_generate(x, x_dual, h, pde_info)
%%
N = pde_info.N;

h1 = x_dual(2:end-1)-x(1:end-1);
h2 = x(2:end)-x_dual(2:end-1);

x_int1 = get_integration_points(x(1:end-1), x_dual(2:end-1));
x_int2 = get_integration_points(x_dual(2:end-1), x(2:end));

%%
p = fun_all(x_dual, 'p');

q_values1 = fun_all(x_int1, 'q');
q_values2 = fun_all(x_int2, 'q');

r_values1 = fun_all(x_int1, 'r');
r_values2 = fun_all(x_int2, 'r');

V_a1 = basis_a(x_int1, repmat(x(2:end),1,5), repmat(h,1,5));
V_a2 = basis_a(x_int2, repmat(x(2:end),1,5), repmat(h,1,5));

V_b1 = basis_b(x_int1, repmat(x(1:end-1),1,5), repmat(h,1,5));
V_b2 = basis_b(x_int2, repmat(x(1:end-1),1,5), repmat(h,1,5));

%%

A1_ele = repmat(p(2:end-1),1,4).*[1./h, -1./h, -1./h, 1./h];

A2_ele = [ numerical_int(h1, q_values1.*repmat(-1./h, 1, 5)), numerical_int(h1, q_values1.*repmat(1./h, 1, 5)),...
           numerical_int(h2, q_values2.*repmat(-1./h, 1, 5)),  numerical_int(h2, q_values2.*repmat(1./h, 1, 5))];

A3_ele = [ numerical_int(h1, r_values1.*V_a1), numerical_int(h1, r_values1.*V_b1),...
           numerical_int(h2, r_values2.*V_a2), numerical_int(h2, r_values2.*V_b2)];

A_ele =  reshape(A1_ele+A2_ele+A3_ele, [], 1);

%%

f_values1 = fun_all(x_int1, 'f');
f_values2 = fun_all(x_int2, 'f');

F_ele = reshape([numerical_int(h1, f_values1), numerical_int(h2, f_values2)],[],1);

%%

ii = reshape([(1:N)', (1:N)', (2:N+1)', (2:N+1)'], [], 1);
jj = reshape([(1:N)', (2:N+1)', (1:N)', (2:N+1)'], [], 1);

A = sparse(ii, jj, A_ele, N+1, N+1);
F = accumarray(reshape([(1:N)', (2:N+1)'], [], 1), F_ele, [N+1,1]);

end
