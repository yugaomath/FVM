function [x, x_dual, h] = mesh_generate(pde_info)
N = pde_info.N;
deltah = (pde_info.right-pde_info.left)/(2*N);

x = (pde_info.left: deltah: pde_info.right)';
% x_dual = [x(1);(x(1:end-1)+x(2:end))/2;x(end)];

positions=[-0.577350269189626, 0.577350269189626];
% 
x1 = x(1:2:end-2);
x2 = x(3:2:end);
h=x2-x1;
inter = h*0.5*positions+repmat((x1+x2)*0.5,1,2);
x_dual = [pde_info.left; reshape(inter',[],1); pde_info.right];

end