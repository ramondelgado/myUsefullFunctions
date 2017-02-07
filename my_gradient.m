function grad=my_gradient(f,x0,step_size)
% MY_GRADIENT numerically approximate the gradien of  f(x)
% USAGE: grad=my_gradient(f,x0,step_size)
% INPUTS:
%       f: function handle of f(x)
%       x0: vector were the gradient will be computed
%       step_size: step size used to approzimate the gradient
% OUTPUTS:
%       grad: gradient of f(x) evaluated at x0

% Ramon A. Delgado 

grad=zeros(size(x0));
f0=f(x0);
for k=1:length(x0)
    x=x0;
    x(k)=x0(k)+step_size;
    f1=f(x);
    grad(k)=(f1-f0)/step_size;
end
end

