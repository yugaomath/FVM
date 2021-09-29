function y = numerical_int(h,values)
%% Gauss Quadrature formula
weights=[0.236926885056189;0.478628670499366;0.568888888888889;0.478628670499366;0.236926885056189];
y=0.5*(values*weights).*h;
end