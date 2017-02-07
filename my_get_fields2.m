function [ varargout ] = my_get_fields2(my_struct,varargin )
%MY_GET_FIELDS Return values from the fields existing fields in the struct.
%   Usage: [val1,val2,...]=my_get_fields2(s,'field_name1','field_name2',...)

% Ramon A. Delgado

if nargin-1>nargout
    warning('The number of outputs is less than the number of fileds requested');
end
if nargin-1<nargout
    warning('The number of outputs is greater than the number of fileds requested');
end



variables_defined=ismember(varargin,fields(my_struct));
% if numel(variables_defined)==1 && ~all(variables_defined)
%     warning('Empty struct.');
%     varargout=cell(1,nargout);
% else
if ~all(variables_defined)
    warning(['Fields "',sprintf(' %s ',varargin{~variables_defined}) ,'" are not defined in the struct'])
end
    if nargout>0
    for i=1:nargout
        if i<=nargin-1
            if variables_defined(i)
                varargout{i}=my_struct.(varargin{i});
            else
                varargout{i}=[];
            end
                
        else
            varargout{i}=[];
        end
    end
    
    end

end




