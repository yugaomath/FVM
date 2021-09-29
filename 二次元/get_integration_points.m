function y = get_integration_points(x1, x2)
%% Get integration points
positions=[-0.906179845938664,-0.538469310105683,0,0.538469310105683,0.906179845938664];
h=x2-x1;
y=h*0.5*positions+repmat((x1+x2)*0.5,1,5);
end