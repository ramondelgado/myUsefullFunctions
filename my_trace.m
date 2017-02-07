function t = my_trace(A,B)
%MY_TRACE efficient calculation of trace(A*B)
%
% Usage y=my_trace(A,B)

% Ramon A. Delgado

t=sum(sum(A.*B'));

end

