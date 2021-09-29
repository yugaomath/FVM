clc
close all
clear all
format long

%% model 

% Eq:  -(pu')'+qu'+ru=f;
% DD:  u(a) = alpha,     u(b) = belta;
% DN:  u(a) = alpha,     u'(b) = belta;
% ND:  u'(a) = alpha,    u(b) = belta;

%% parameter

pde_info.left = 0;      
pde_info.right = 1;

pde_info.left_D =  fun_all(pde_info.left, 'u');    
pde_info.right_D = fun_all(pde_info.right, 'u');

pde_info.left_N =  fun_all(pde_info.left, 'ux'); 
pde_info.right_N = fun_all(pde_info.right, 'ux');

pde_info.N = 20;

%% solve equation

tic
[h, x, u] = FVM_1D(pde_info);
toc

%% plt figure
figure
plot(x, u, x, fun_all(x, 'u'), 'r*');
title('sin(\pix)')
legend('数值解','真解')
xlabel('x')
ylabel('y')

%% convergence order
M = 5;
pde_info.N = 25;
[L2_order, H1_order]=convergence_order(M, pde_info);
L2_order
H1_order
