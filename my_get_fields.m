function [ varargout ] = my_get_fields(my_struct,varargin )
%MY_GET_FIELDS create variables from the fields of a struct with variable name and values specified by existing fields in the struct. 
%   Usage: my_get_fields(s,'field_name1','field_name2',...)

% Ramon A. Delgado

variables=evalin('caller','who');
variables_defined=isfield(my_struct,varargin);
if all(variables_defined)
    for i=1:nargin-1
        if any(strcmp(variables,varargin{i}))
            warning(['Variables "',varargin{i},'" are already defined in the caller workspace'])
        end
        assignin('caller',varargin{i},my_struct.(varargin{i}));
    end
else
    error(['Variables "',sprintf(' %s ',varargin{~variables_defined}) ,'" are not defined in the struct'])
end
if nargout>0
    if nargin-1>=nargout
        for i=1:nargout
            varargout{i}=my_struct.(varargin{i});
        end
    else
        for i=1:nargout
            varargout{i}=true;
        end
    end
end
end



