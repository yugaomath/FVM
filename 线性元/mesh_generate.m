function [x, x_dual, h] = mesh_generate(pde_info)
N = pde_info.N;
deltah = (pde_info.right-pde_info.left)/N;

x = (pde_info.left: deltah: pde_info.right)';
x_dual = [x(1);(x(1:end-1)+x(2:end))/2;x(end)];

h = x(2:end)-x(1:end-1);
end