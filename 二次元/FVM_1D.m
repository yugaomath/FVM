function [h, x, u] = FVM_1D(pde_info)
[x, x_dual, h] = mesh_generate(pde_info);    
[A, F] = matrix_vector_generate(x, x_dual, h, pde_info);
u = solveAF(A, F, x, pde_info);
end