function [u,lambda] = my_recursive_eig_update(u0,lambda0,A,alpha)
%MY_RECURSIVE_EIG_UPDATE Update the current eigenvalues and eigenvectors 
%       estimates using the current estime A. This function implements 
%       the recursive eigenvector, and eigenvalue estimation using 
%       stochastic aproximations based on the paper 
%       "Recursive estimation for ordered eigenvectors of symmetric matrix 
%       with observation noise" by H-F. Chen, H-T. Fang and L-L. Zhang 2011
%
% Usage [u,lambda] = my_recursive_eig_update(u0,lambda0,A,alpha)
%   Inputs: u0: matrix containing the initial estimates of the eigenvectors
%           lambda0: vector containing initial estimates of the eigenvalues
%           A : Covariance matrix at which we estimate the eigenvalues
%           alpha: update factor, 0<alpha<1, typical alpha=0.1. 
%   Outputs: u: updated eigenvector estimates
%            lambda: updated eigenvalue estimate
% 
%
% Ramon A. Delgado on Feb 2012 

[N_var,N_eig]=size(u0); % get the number of variables and the number of eigenvalues to estimate

% initialize matrices
V=cell(N_eig,1);
P=cell(N_eig,1);
u=zeros(N_var,N_eig);

V{1}=u0(:,1);
P{1}=eye(N_var)-V{1}*((V{1}'*V{1})\V{1}');

u(:,1)=(1-alpha)*u0(:,1)+alpha*(eye(N_var)+A)*u0(:,1);% first eigenvector
u(:,1)=u(:,1)/norm(u(:,1));% normalize

% Update each eigenvector
for j=2:N_eig
   V{j}=[V{j-1},P{j-1}*u0(:,j)];
   P{j}=eye(N_var)-V{j}*((V{j}'*V{j})\V{j}');
   u(:,j)=P{j-1}*((eye(N_var)+alpha*A*P{j-1})*u0(:,j));
   % normalize eigenvectors
   if norm(u(:,j))~=0
        u(:,j)=u(:,j)/norm(u(:,j));
   else
        u(:,j)=u(:,j)/norm(u(:,j));
   end
end
% update Eigenvalues estimates
lambda=(1-alpha)*lambda0+alpha*diag(u0.'*A*u0);
end

  