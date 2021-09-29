function y = fun_all(x, fun_name)
%{
-------------------- Annotate --------------------
u:          true solution
q:          parameter
f:          right
--------------------- Size -------------------------
u(q,f):     the same size of x(y)
--------------------  End ---------------------------
%}
%%


switch fun_name
    
    case 'u'
        y = exactSolution(x);
        
    case 'ux'
        
        y = exactSolution_gradient(x);  
        
    case 'p'
        
        y = diffusion(x);
        
    case 'q'
        
        y = convection(x);
        
    case 'r'
        
        y = constant(x);
 
    case 'f'
        
        y = rightFunction(x);
       
end

end

function z = exactSolution(x)
%% Exact solution
z = sin(pi.*x);
% z = exp(x);
end

function zx=exactSolution_gradient(x)
%% The gradient of exact solution
zx = pi.*cos(pi.*x);
% zx = exp(x);
end

function p = diffusion(x)
%% p
p = x.^3+x.^2+2;
% p = ones(size(x));
end

function q = convection(x)
%% q
% q = zeros(size(x));
% q = ones(size(x));
q = exp(x);
end

function r = constant(x)
%% r
% r = zeros(size(x));
% r = ones(size(x));
r = x.^2+1;
end

function f = rightFunction(x)
%% f
u = exactSolution(x);
u_x = exactSolution_gradient(x);
p = diffusion(x);
q = convection(x);
r = constant(x);

px = 3*x.^2+2*x;
uxx = -pi*pi*sin(pi*x);
% uxx = exp(x);

f = -(px.*u_x+p.*uxx)+q.*u_x+r.*u;

end
