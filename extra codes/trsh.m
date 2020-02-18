function [R] = trsh(t, a, r)
%   UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   a=1; c=3; r=6;
R=a./r*(log(1+exp(t*r)));
end

