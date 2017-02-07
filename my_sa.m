function [r_best,big_flag]=my_sa(f,r0,stepsize,fcond)
% MYSA My Simulated annealing implementation
%
% 

% Ramon A. Delgado

% parameters
N=length(r0);

T=100;
MaxIter=100*length(r0)^2;

Tolch=1e-6;
Tmin=1e-9;

iter=1;

cooldown=exp(1/MaxIter*log(Tmin));
% Initalize

cost_old  = f(r0);
cost_best = cost_old;
cost_best_old=100;
r_best    = r0;
r  =  r0;

big_flag=-1;
while (big_flag==-1)&&(iter<MaxIter),
	%Choose new point randomly and check if inside bounds
	flag = 0;

    while flag == 0
        rp = r + stepsize/(log(iter)+1)*randn(N,1);
        rp=sort(rp);
        if fcond(rp)
            flag = 1;
        end
    end
	
	%calculate new cost using xp
	cost_new = f(rp);
	
	%Determine if we accept this point or not
	if cost_new < cost_old, %If new cost < old cost then accept 
		r         = rp;
		cost_old  = cost_new;
	elseif rand < exp(-abs(cost_old-cost_new)/T) %Otherwise, accept the new point with a certain probabiltiy
		r         = rp;
		cost_old  = cost_new;
    end
    
    if cost_new < cost_best,
        r_best = rp;
        cost_best_old=cost_best;
        cost_best = cost_new;
    end
    
    if abs((cost_best_old-cost_best)/cost_best_old)<Tolch
        big_flag=0;
    end
        
	%Now cool the temperature
    T=cooldown*T;
    iter=iter+1;
    
    if T<=Tmin
        big_flag=-2;
    end
       
	
end


