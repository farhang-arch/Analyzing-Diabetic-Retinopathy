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

      % Generation of a random number  
      R=rand;
      
         % Generation of Random Variables 
          if R<0.5      % If R<0.5 stepdown by -1

                 S=-1;

          elseif R>0.5  % If R>0.5 stepdown as by +1

                 S=1;
                 K = K+1;   % If R>0.5 increase successes 

          end

       Z(i+1) = S + Z(i);    % Generation of Random Walk by add each Random Variable with prior step
       Q(j,i) = Z(i);        % Building a matrix of random variables in each time(include: j = jth ensemble & i = ith Random Variable)

    end

end

% Mean number of success in each ensemble
disp(' Mean number of success in each ensemble ')
K = K/si

[phat,psi] = mle(Q(:,1000),'distribution','normal');  % Fit a distribution to Random Variables and return phat as mean and variance of Normal distribution 
                                                      % psi as best estimation of Random variables
 disp(' Mean of distribution: ')   
 phat(1)
 disp(' standard deviation: ')   
 phat(2)
 disp(' Differance of mean of distribution and calcualted mean: ')   
 abs( phat(1) - 0 ) 
 disp(' Differance of standard deviation of distribution and calculated standard deviation: ')   
 abs( phat(2)- sqrt(t) )

% Plot distribution of Z                                                      
z=-4*t:0.001:4*t;
f=(1/sqrt(2*pi*t))*exp(-(z.^2)/(2*t));
plot(z,f),grid on
xlabel('f(z)')
ylabel('z')
title('distribution of Z')

