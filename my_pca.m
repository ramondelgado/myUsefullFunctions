function [A,Va] = my_pca(R,n)
%My_PCA Performs Principal Components Analysis
% Usage: [A,Va] = my_pca(R,n)
%

% Ramon A. Delgado

m=size(R,1);
[Va,Da]=eigs(R,n);
lambda=diag(Da);
[~,idx]=sort(lambda,'descend');
Va=Va(:,idx);

A=Va(:,1:n).*repmat(sqrt(abs(lambda(1:n)')),m,1);

end

