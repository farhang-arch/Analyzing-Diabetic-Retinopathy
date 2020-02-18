function z = pq_mean( A, a, p, q )
% p<=1; q>1
switch a
    case 0
        A=abs(A);
        N=length(A);
        s=0;
        for i=1:N
            s=s+A(i)^p;
        end
        e=0;
        for i=1:N
            e=e+A(i)^q;
        end
        m=1/p;
        n=-1/q;
        z=-1000*(((1/N)*s)^m)*(((1/N)*e)^n);
    case 1 
        A=abs(A);
        l=size(A);
        A=reshape(A,1,l(1)*l(2));
        N=length(A);
        s=0;
        for i=1:N
            s=s+A(i)^p;
        end
        e=0;
        for i=1:N
            e=e+A(i)^q;
        end
        m=1/p;
        n=-1/q;
        z=-1000*(((1/N)*s)^m)*(((1/N)*e)^n);
end
end

