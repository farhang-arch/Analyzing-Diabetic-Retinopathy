function [ y ] = pad( x, a, r, m, n )
%   UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f=2./(1+exp(-r*sqrt(2).*sinh(sqrt(8)*a*x/r)))-1;
y=pade(f,'Order',[m m],'ExpansionPoint',n);

end

