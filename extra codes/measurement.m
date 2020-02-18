A=imread('phantom.jpg');
w=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        w(i,j)=A(i,j);
    end
end
X=w;
C=fdct_wrapping(X, 1, 1, 2, 16);
curve_1=C{1}{1};
q=size(curve_1);
u=reshape(curve_1,1,q(1)*q(2));
y=[];
for i=1:16
    curve=C{2}{i};
    p=size(curve);
    curve_re=reshape(curve,1,p(1)*p(2));
    t=curve_re;
    y=[y t];
end
CC=[u y];
sc=sparse_model(CC,1);
[D,S]=wavedec2(X,1,'sym12');
sw=sparse_model(D,1);







