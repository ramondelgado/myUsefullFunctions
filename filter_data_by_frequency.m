function [ y_filtered,F] = filter_data_by_frequency(y,p1,p2)
% FILTER_DATA_BY_FREQUENCY Filters a real-valued time serie in a frequency band.
% 
% usage: [ y_filtered,F] = filter_data_by_frequency(y,p1,p2)
% Inputs:
%       p1: start of the frequency band (0<= p1 < p2 =< pi)
%       p2: end of the frequency band (0<= p1 < p2 <= pi)
%
% This function use the real Fourier Transform to compute the frequency range,
% then the output y_filtered will always be real-valued.
% 

% Ramon delgado, January 2017 

N=size(y,1);
[F,m]=robust_E(N,[p1 p2]);
y_filtered=ifft(F'*F*fft(y));


end
function [F,m]=robust_E(N,p)
% ROBUST_E generate the matrix MT of the Real Discrete Fourier Transform
% and select the low frequencies in function of the percentage p
%
% usage: create_E(N,ny,p)
%       p: frequency band to consider (full frequency band p=[0 pi])
%       ny: number of outputs of the model
%       N: Number of data
m1=floor(p(1)/2/pi*N)+1;
m2=floor(p(2)/2/pi*N)+1;


%FM=1/sqrt(N)*fft(eye(N));


MR=sparse(m2-m1+1,N);
% 
% row=1;
% if m1>1;
%   for kk=1:m1-1;
%    if FMF(kk,N)==real(FMF(kk,N))
%        MR(row,kk)=1;
%        row=row+1;
%    else
%        MR(row,kk)=sqrt(2)/2;
%        MR(row,N-kk+2)=sqrt(2)/2;
%        row=row+1;
%        
%        MR(row,kk)=-1i*sqrt(2)/2;
%        MR(row,N-kk+2)=1i*sqrt(2)/2;
%        row=row+1;
%    end
%   end
% end
%  
%  
% if m2<(floor(N/2)+1);
%   for jj=m2+1:(floor(N/2)+1);
%     if FMF(jj,N)==real(FMF(jj,N))
%        MR(row,jj)=1;
%        row=row+1;
%    else
%        MR(row,jj)=sqrt(2)/2;
%        MR(row,N-jj+2)=sqrt(2)/2;
%        row=row+1;
%        
%        MR(row,jj)=-1i*sqrt(2)/2;
%        MR(row,N-jj+2)=1i*sqrt(2)/2;
%        row=row+1;
%    end
%   end
% end

row=1;
m=0;
for ii=m1:m2
   if norm(imag(FMF(ii,N)))<sqrt(eps)
       MR(row,ii)=1;
       row=row+1;
       m=m+1;
   else
       MR(row,ii)=sqrt(2)/2;
       MR(row,N-ii+2)=sqrt(2)/2;
       row=row+1;
       m=m+1;
       
       MR(row,ii)=-1i*sqrt(2)/2;
       MR(row,N-ii+2)=1i*sqrt(2)/2;
       row=row+1;
       m=m+1;
   end
end
  

 F=MR;

end
function y=FMF(ii,N)
y=1/sqrt(N)*exp(-1i*2*pi/N*(ii-1)*(0:N-1));
end
