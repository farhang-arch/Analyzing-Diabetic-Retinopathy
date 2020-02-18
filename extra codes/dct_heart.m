clc
clear
close all
A=imread('heart.jpg');
B=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        B(i,j)=A(i,j);
    end
end
C=dct2(B);
rr=size(C);
i=165;
o=80;        
D=C(rr(1)-i:rr(1),rr(2)-o:rr(2));
pp=60;
l=prod(size(D));
Dre=reshape(D,1,l);
Ds=sort(abs(Dre));
n=ceil((pp/100)*l);
f=Ds(l-n+1:end);
for k=1:size(D,1)
    for j=1:size(D,2)
        for z=1:length(f)
            if abs(D(k,j))==f(z)
                D(k,j)=D(k,j);
                break
            elseif z==length(f)
                D(j,k)=0;
            end
        end
    end
end
C(rr(1)-i:rr(1),rr(2)-o:rr(2))=D;
CC=C;
Areconstruct=idct2(CC);
diffimg=B-Areconstruct;
diff=sum(sum(abs(diffimg)));
Aint=uint8(Areconstruct);
figure;imshow(A);
title('heart');
figure;imshow(Aint);
title('heart_reconstruct');

