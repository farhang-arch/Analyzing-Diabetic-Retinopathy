function [ y ] = mysig( x, c, a, d )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
y=(1+d)./(1+exp(-a.*(x-c)))-d/2;
y=(y>=0).*y;
if y > 1
    y = 1;
end

end

