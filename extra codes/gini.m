function y = gini(x)
% calculate the value of sparsity using Gini index;
% x: m*n matrix;

x=abs(x);
l=size(x);
N=l(1)*l(2);
x_re=reshape(x,1,N);
x_prime=sort(x_re);
d=sum(x_prime);
s=0;
for i=1:N
    s=s+(x_prime(i)/d)*((N-i+0.5)/N);
end
y=1-2*s;
end

