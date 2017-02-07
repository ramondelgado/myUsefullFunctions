function [ s ] = my_struct( varargin )
%MY_STRUCT create an struct with fields name and values of the specified existing variables. 
%   Usage: s=my_struct('var_name1','var_name2',...)

% Ramon A. Delgado

variables=evalin('caller','who');
if all(ismember(varargin,variables))
    for i=1:nargin
        s.(varargin{i})=evalin('caller',varargin{i});
    end
else

    error('One or more variables are not defined in the workspace')
end

end

