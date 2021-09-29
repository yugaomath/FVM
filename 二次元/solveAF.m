function u = solveAF(A,F,x, pde_info)
%% solve A\F

N = pde_info.N;

%% DD boundary

% F(1) = pde_info.left_D;
% F(2*N+1) = pde_info.right_D;
% A([1,2*N+1],:) = 0;
% A(1,1) = 1;
% A(2*N+1,2*N+1) = 1;
% u = A\F;

%% DN boundary
 
F(1) = pde_info.left_D;
F(2*N+1) = F(2*N+1)+fun_all(pde_info.right, 'p')*pde_info.right_N;
A(1,:) = 0;
A(1,1) = 1;
u = A\F;

%% ND boundary
 
% F(1) = F(1)-fun_all(pde_info.left, 'p')*pde_info.left_N;
% F(2*N+1) = pde_info.right_D;
% A(2*N+1,:) = 0;
% A(2*N+1,2*N+1) = 1;
% u = A\F;

end