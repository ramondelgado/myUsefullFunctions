%
% make_mex_files Makes the mex files of the some functions.
% 
% Notice that the mex compiler may not be configured in your machine. To configure 
% the mex compiler please run the following command:
% mex -setup
% and follow the instructions. 


% last revision: December 2016

% setup mex configuration 
mexcfg = coder.config('mex');
mexcfg.EnableVariableSizing=true;
mexcfg.DynamicMemoryAllocation = 'AllVariableSizeArrays';

% declare variables
matrixVariable=coder.typeof(0,[Inf,Inf],1); % matrix with variable size
vectorVariable=coder.typeof(0,[Inf,1],[1 0]); % vector with variable size
scalarVariable=coder.typeof(0,[1,1],[0 0]);  %

% The following code needs to be modified
% In this example the function to be compiled is 
% myfunctionName(matrixVariable,vectorVariable,scalarVariable)
%
try
    codegen myfunctionName.m -args {matrixVariable,vectorVariable,scalarVariable} -config mexcfg -o myfunctionName
catch
    fprintf('Could not make a mex file for myfunctionName\n')
end

