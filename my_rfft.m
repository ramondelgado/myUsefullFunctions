function F=my_rfft(Y)
%RFFT compute the Real Fourier Transform of a vector
%
%Use: Y=rfft(y)
%Input y: a column vector;
%Output Y: Real Fourier Transform of vector y

% Ramon A. Delgado

n=size(Y,1);
F=1/sqrt(n)*Mreal(n)*fft(Y);


% Mreal generate the matrix MT of the Real Discrete Fourier Transform
end
function M=Mreal(N)

m1=floor(1/2/pi*N)+1;
m2=floor(1/2*N)+1;

FM=1/sqrt(N)*fft(eye(N));

MR=sparse(N,N);

row=1;
if m1>1;
  for kk=1:m1-1;
   if FM(kk,:)==real(FM(kk,:))
       MR(row,kk)=1;
       row=row+1;
   else
       MR(row,kk)=sqrt(2)/2;
       MR(row,N-kk+2)=sqrt(2)/2;
       row=row+1;
       
       MR(row,kk)=-j*sqrt(2)/2;
       MR(row,N-kk+2)=j*sqrt(2)/2;
       row=row+1;
   end
  end
end
 
 
if m2<(floor(N/2)+1);
  for jj=m2+1:(floor(N/2)+1);
    if FM(jj,:)==real(FM(jj,:))
       MR(row,jj)=1;
       row=row+1;
   else
       MR(row,jj)=sqrt(2)/2;
       MR(row,N-jj+2)=sqrt(2)/2;
       row=row+1;
       
       MR(row,jj)=-j*sqrt(2)/2;
       MR(row,N-jj+2)=j*sqrt(2)/2;
       row=row+1;
   end
  end
end


m=0;
for ii=m1:m2;
   if FM(ii,:)==real(FM(ii,:))
       MR(row,ii)=1;
       row=row+1;
       m=m+1;
   else
       MR(row,ii)=sqrt(2)/2;
       MR(row,N-ii+2)=sqrt(2)/2;
       row=row+1;
       m=m+1;
       
       MR(row,ii)=-j*sqrt(2)/2;
       MR(row,N-ii+2)=j*sqrt(2)/2;
       row=row+1;
       m=m+1;
   end
end
  

 M=full(MR);
end
