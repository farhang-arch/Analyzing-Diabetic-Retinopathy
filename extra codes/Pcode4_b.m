clc
clear all

% Number of Random Variables Xn
t = 1000;

% Number of successes
K = 0;

% Number of ensembles
si = 1000;

% Calculation of ensembles in each interation
for j=1:si

% Starting value of Z(Si , ti)
Z = zeros(1,t); 

    for i=1:t  
      
      % Generation of Random Variables with Normal(0,1) distribution
      S = randn(1);

       Z(i+1) = S + Z(i);    % Generation of Random Walk by add each Random Variable with prior step
       Q(j,i) = Z(i);        % Building a matrix of random variables in each time(include: j = jth ensemble & i = ith Random Variable)

    end

end


[phat,psi] = mle(Q(:,1000),'distribution','normal');  % Fit a distribution to Random Variables and return phat as mean and variance of Normal distribution 
                                                      % psi as best estimation of Random variables
 disp(' Mean of distribution: ')   
 phat(1)
 disp(' standard deviation: ')   
 phat(2)
 disp(' Differance of mean of distribution and calculated mean: ')   
 abs( 0 - phat(1) ) 
 disp(' Differance of standard deviation of distribution and calculated standard deviation: ')   
 abs( sqrt(t) - phat(2) )

% Plot distribution of Z                                                      
z=-4*t:0.001:4*t;
f=(1/sqrt(2*pi*t))*exp(-(z.^2)/(2*t));
plot(z,f),grid on
xlabel('f(z)')
ylabel('z')
title('distribution of Z')

