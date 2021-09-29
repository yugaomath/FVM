clc
close all
clear all

%% model 

% Eq:  -(pu')'+qu'+ru=f;
% DD:  u(a) = alpha,     u(b) = beta;
% DN:  u(a) = alpha,     u'(b) = beta;
% ND:  u'(a) = alpha,    u(b) = beta;

%% parameter
pde_info.left = 0;      pde_info.right = 1;
pde_info.left_D = 0;    pde_info.right_D = 0;
pde_info.left_N = pi;   pde_info.right_N = -pi;
pde_info.N = 50;

%% solve equation
tic
[h, x, u] = FVM_1D(pde_info);
toc

%% plt figure
figure
plot(x, u, x, sin(pi*x), 'r*');
title('sin(\pix)')
legend('数值解','真解')
xlabel('x')
ylabel('y')

%% convergence order
format long
M = 5;
pde_info.N = 20;
[L2_order, H1_order]=convergence_order(M, pde_info);
L2_order
H1_order
