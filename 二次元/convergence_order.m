function [L2_order, H1_order]=convergence_order(M, pde_info)
%% Compute the convergence order

L2_error_array = zeros(1, M);
H1_error_array = zeros(1, M);

L2_order = zeros(1, M-1);
H1_order = zeros(1, M-1);

for i=1:M
    [h, x, u] = FVM_1D(pde_info);
    [L2_error, H1_error] = error_estimate(h, x, u);
    L2_error_array(i) = L2_error;
    H1_error_array(i) = H1_error;
    pde_info.N = pde_info.N*2;
end

for i=1:M-1
    L2_order(i) = log2(L2_error_array(i)/L2_error_array(i+1));
    H1_order(i) = log2(H1_error_array(i)/H1_error_array(i+1));
end

end