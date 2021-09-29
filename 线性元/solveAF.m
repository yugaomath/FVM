function u = solveAF(A,F,x, pde_info)
%% solve A\F
N = pde_info.N;
%% DD boundary

F(1) = pde_info.left_D;
F(N+1) = pde_info.right_D;
A([1,N+1],:) = 0;
A(1,1) = 1;
A(N+1,N+1) = 1;
u = A\F;
%% DN boundary
 
% F(1) = pde_info.left_D;
% F(N+1) = F(N+1)+fun_all(x(end), 'p')*pde_info.right_N;
% A(1,:) = 0;
% A(1,1) = 1;
% u = A\F;
%% ND boundary
 
% F(1) = F(1)-fun_all(x(1), 'p')*pde_info.left_N;
% F(N+1) = pde_info.right_D;
% A(N+1,:) = 0;
% A(N+1,N+1) = 1;
% u = A\F;
end