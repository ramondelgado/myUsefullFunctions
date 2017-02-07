function [x_min,flag]=my_BFGS_grad(f,x0,g)%#codegen
% GRADDESCENT Implement a gradient descent search, using BFGS algorithm,
% and finite differences.
% Usage [x_min,flag]=my_BFGS_grad(f,x0,g)
% Inputs
%   f: is the function handle of the cost to optimize,f(x).
%   x0: is the initial point.
%   g: is the function handle of the gradient.

% Ramon Delgado

MaxIter=max(300,floor((length(x0))*log(length(x0))^2));
%MaxIter=max(300,floor((length(x0))^2));
iter=1;
TolChF=eps;
TolGrad=eps;
default_step=eps^(3/4);
step_size=default_step;

N=length(x0);

H=eye(N);
flag=-1;

while (flag==-1)&&(iter<MaxIter)
    
    J0=f(x0);
    G0=g(x0);
    %G0=gradf(f,x0,step_size);
    
    Dx=H*G0;
   max_Dx=max(abs(Dx));
     if max_Dx>0.3
         Dx=0.3*Dx/max_Dx;
     end
    [x1,step_size,linesearch_flag]=backtrack_linsearch(f,x0,-Dx);
    if linesearch_flag==-1
        flag=2; % cannot decrease the fuction in the given direction
    else
        if step_size>0.1
            step_size=default_step;
        end
        
        if any(isnan(x1))
            flag=-10;
        else
            G1=g(x1);
            %G1=gradf(f,x1,step_size);
            J1=f(x1);
            if x1~=x0
                if abs((J1-J0)/J0)<TolChF
                    flag=0; % Change in the objetive function is small than the tolerance
                end
            end
            
            if norm(G1)<TolGrad
                flag=1; % gradient is too small
            end
            DG=G1-G0;
            u=(x1-x0)/((x1-x0)'*DG)-H*DG/(DG'*H*DG);
            uu=u*u';
            H=H+(x1-x0)*(x1-x0)'/((x1-x0)'*(G1-G0))...
                -((H*(G1-G0))*(H*(G1-G0))')/((G1-G0)'*H*(G1-G0))...
                +(G1-G0)'*H*(G1-G0)*uu;
            [~,p]=chol(H);
            
            if p>0;
                
                if all(diag(H)>0)
                    warning('H must be positive definite, fixed with diagonal of H')
                    H=eye(size(H)).*H;
                else
                    warning('H must be positive definite, fixed with eye(N)')
                    H=eye(N);
                end
            end
            x0=x1;
        end
    end
    iter=iter+1;
end
x_min=x1;
end
%-------------------------------------------
function [x_opt,t,myflag]=backtrack_linsearch(f,x0,df)
%  implements backtracking line search

MaxIter=length(x0);
alpha=.25;
beta=.5;
n=norm(df);

fx0=f(x0);
fxmin=fx0;
xmin=x0;

myflag=0;
t=1;
iter=1;
while (myflag==0)&&(iter<MaxIter)
    x1=x0+t*df;
    fval=f(x1);
    if fval<fxmin
        xmin=x1;
    end
    
    Cval=fx0+alpha*t*n^2;
    if Cval>=fval
        myflag=1;
    else
        t=beta*t;
    end
    iter=iter+1;
end
x_opt=x1;
% if xmin==x0
%     x_opt=x0;
%     myflag=-1;
% else
%     x_opt=x1;
% end
end

%--------------------------
function grad=gradf(f,x0,step_size)
grad=zeros(size(x0));
f0=f(x0);
for k=1:length(x0)
    x=x0;
    x(k)=x0(k)+step_size;
    f1=f(x);
    grad(k)=(f1-f0)/step_size;
end
end
