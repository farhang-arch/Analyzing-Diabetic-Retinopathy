function s = GMSM( A )
% input:
% A is the input vector. I should note that A must be vector.
% output:
% s is the sparsity value associated with the vector A.

A=abs(A);
obj=gmdistribution.fit(A',1);
s=(obj.Sigma)/(obj.mu)^2;

end

