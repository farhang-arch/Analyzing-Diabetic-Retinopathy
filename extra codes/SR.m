%---------------------- Expriment  -----------------------
%%------------------------------image------------------------------
A=imread('0.bmp');
w = zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        w(i,j)=A(i,j);
    end
end
X=w;
%fdct_wrapping----------------------------------------------------------
C = fdct_wrapping(X,1,1,2,16);
cz=C;
pp = input('please insert a number between zero and 100 = ');
% all coeff
c1=cz{1,1}{1,1}(:,:);
length_c1=size(c1,1)*size(c1,2);
s2=0;
for i=1:16
    c2=cz{1,2}{1,i}(:,:);
    s2=s2+(size(c2,1)*size(c2,2));
end
% total amount
total_coeff=length_c1+s2;
remain_coeff=length_c1+((1-pp/100)*s2);
% SR computation
sr = remain_coeff/total_coeff;

