function [ y ] = thresh_func( x, a, r, c )
%   UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% a=8;r=5;c=c+[0.05,0.1]
y=1./(1+exp(-r*sqrt(2).*sinh(sqrt(8)*a*(x-c)/r)));

end

