function d = max_s( x, a )
%   x input
%   d output
switch a
    case 0
        x=abs(x);
        n=length(x);
        num=sum(x);
        den=max(x);
        d=-(1/n)*(num/den);
    case 1
        x=abs(x);
        xn=reshape(x,1,size(x,1)*size(x,2));
        n=length(xn);
        num=sum(xn);
        den=max(xn);
        d=-(1/n)*(num/den);
end

