clc
clear all

clc
clear all

% Number of Random Variables Xn
t = 1000;

% Poisson parameter
lambda = 1;

% Number of successes
K = 0;

% Number of ensembles
si = 1000;

% Calculation of ensembles in each interation
for j=1:si

% Poisson number generation   
t = poissrnd(lambda)+1;
 
% Starting value of Z(Si , ti)
Z = zeros(1,t); 

    for i=1:t  
      
       S = randn(1);         % Generation of a gaussian Random Variable N(0,1)

       Z(i+1) = S + Z(i);    % Generation of Random Walk by add each Random Variable with prior step
       
    end

    Q(j) = Z(t);        % Lastest value of Z in each ensemble

end


[phat] = mle(Q,'distribution','normal');  % Fit a distribution to Random Variables and return phat as mean and variance of Normal distribution 
                                                     
 disp(' Mean of distribution: ')   
 phat(1)
 disp(' standard deviation: ')   
 phat(2)
 disp(' Differance of mean of distribution and calculated mean: ')   
 abs( 0 - phat(1) ) 
 disp(' Differance of standard deviation of distribution and calculated standard deviation: ')   
 abs( 1 - phat(2) )

% Plot distribution of Z                                                      
z=-4:0.001:4;
f=(1/sqrt(2*pi*t))*exp(-(z.^2)/(2*t));
plot(z,f),grid on
xlabel('f(z)')
ylabel('z')
title('distribution of Z')





