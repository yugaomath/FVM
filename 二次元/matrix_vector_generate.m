function [A, F] = matrix_vector_generate(x, x_dual, h, pde_info)
%%

N = pde_info.N;

h1 = x_dual(2:2:end-2)-x(1:2:end-2);
h2 = x_dual(3:2:end-1)-x_dual(2:2:end-2);
h3 = x(3:2:end)-x_dual(3:2:end-1);

x_int1 = get_integration_points(x(1:2:end-2), x_dual(2:2:end-2));
x_int2 = get_integration_points(x_dual(2:2:end-2), x_dual(3:2:end-1));
x_int3 = get_integration_points(x_dual(3:2:end-1),x(3:2:end));

%%

p1 = fun_all(x_dual(2:2:end-2), 'p');
p2 = fun_all(x_dual(3:2:end-1), 'p');

q_values1 = fun_all(x_int1, 'q');
q_values2 = fun_all(x_int2, 'q');
q_values3 = fun_all(x_int3, 'q');

r_values1 = fun_all(x_int1, 'r');
r_values2 = fun_all(x_int2, 'r');
r_values3 = fun_all(x_int3, 'r');


%%

V_a1 = basis_a(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_a2 = basis_a(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_a3 = basis_a(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

V_b1 = basis_b(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_b2 = basis_b(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_b3 = basis_b(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

V_c1 = basis_c(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_c2 = basis_c(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
V_c3 = basis_c(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

%%

Vx_a1 = basis_ax(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_a2 = basis_ax(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_a3 = basis_ax(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

Vx_b1 = basis_bx(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_b2 = basis_bx(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_b3 = basis_bx(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

Vx_c1 = basis_cx(x_int1, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_c2 = basis_cx(x_int2, repmat(x(1:2:end-2),1,5), repmat(h,1,5));
Vx_c3 = basis_cx(x_int3, repmat(x(1:2:end-2),1,5), repmat(h,1,5));

%%

Vxdual_al = basis_ax(x_dual(2:2:end-2), x(1:2:end-1), h);
Vxdual_b1 = basis_bx(x_dual(2:2:end-2), x(1:2:end-1), h);
Vxdual_c1 = basis_cx(x_dual(2:2:end-2), x(1:2:end-1), h);

Vxdual_a2 = basis_ax(x_dual(3:2:end-1), x(1:2:end-1), h);
Vxdual_b2 = basis_bx(x_dual(3:2:end-1), x(1:2:end-1), h);
Vxdual_c2 = basis_cx(x_dual(3:2:end-1), x(1:2:end-1), h);


%%

A1_ele = [ -p1.*Vxdual_al, -p1.*Vxdual_b1, -p1.*Vxdual_c1,  ...
            p1.*Vxdual_al - p2.*Vxdual_a2,  p1.*Vxdual_b1 - p2.*Vxdual_b2,  p1.*Vxdual_c1 - p2.*Vxdual_c2, ...
            p2.*Vxdual_a2,  p2.*Vxdual_b2,  p2.*Vxdual_c2];

A2_ele = [ numerical_int(h1, q_values1.*Vx_a1), numerical_int(h1, q_values1.*Vx_b1), numerical_int(h1, q_values1.*Vx_c1),...
           numerical_int(h2, q_values2.*Vx_a2), numerical_int(h2, q_values2.*Vx_b2), numerical_int(h2, q_values2.*Vx_c2),...
           numerical_int(h3, q_values3.*Vx_a3), numerical_int(h3, q_values3.*Vx_b3), numerical_int(h3, q_values3.*Vx_c3)];

A3_ele = [ numerical_int(h1, r_values1.*V_a1), numerical_int(h1, r_values1.*V_b1), numerical_int(h1, r_values1.*V_c1),...
           numerical_int(h2, r_values2.*V_a2), numerical_int(h2, r_values2.*V_b2), numerical_int(h2, r_values2.*V_c2),...
           numerical_int(h3, r_values3.*V_a3), numerical_int(h3, r_values3.*V_b3), numerical_int(h3, r_values3.*V_c3)];

       
A_ele =  reshape(A1_ele+A2_ele+A3_ele, [], 1);


%%

f_values1 = fun_all(x_int1, 'f');
f_values2 = fun_all(x_int2, 'f');
f_values3 = fun_all(x_int3, 'f');

F_ele = reshape([numerical_int(h1, f_values1), numerical_int(h2, f_values2), numerical_int(h3, f_values3)],[],1);

%%

ii = reshape([ (1:2:2*N-1)',  (1:2:2*N-1)', (1:2:2*N-1)',...
               (2:2:2*N)',    (2:2:2*N)',   (2:2:2*N)',...
               (3:2:2*N+1)',  (3:2:2*N+1)', (3:2:2*N+1)'], [], 1);
           
jj = reshape([(1:2:2*N-1)', (2:2:2*N)', (3:2:2*N+1)', ...
              (1:2:2*N-1)', (2:2:2*N)', (3:2:2*N+1)', ...
              (1:2:2*N-1)', (2:2:2*N)', (3:2:2*N+1)'], [], 1);

A = sparse(ii, jj, A_ele, 2*N+1, 2*N+1);
F = accumarray(reshape([(1:2:2*N-1)', (2:2:2*N)', (3:2:2*N+1)'], [], 1), F_ele, [2*N+1,1]);

end
