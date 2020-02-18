clc
clear
close all
% finding the r_desired for dct of 4 test images.
A=imread('heart.jpg');
B=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        B(i,j)=A(i,j);
    end
end
C=dct2(B);
rr=size(C);
i=input('please insert a num i= ');
j=input('please insert a num j= ');
C(rr(1)-i:rr(1),rr(2)-j:rr(2))=0;
CC=C;
Areconstruct=idct2(CC);
diffimg=B-Areconstruct;
diff=sum(sum(abs(diffimg)));
Aint=uint8(Areconstruct);
figure;imshow(A);
figure;imshow(Aint);
%%
clc
clear
close all
A=imread('0.bmp');
B=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        B(i,j)=A(i,j);
    end
end
C=dct2(B);
rr=size(C);
a=input('please give me a character = ');
switch a
    case 'lenna'
        i=400;
        D=C(rr(1)-i:rr(1),rr(2)-i:rr(2));
        pp=68;
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
                        D(k,j)=0;
                    end
                end
            end
        end
        C(rr(1)-i:rr(1),rr(2)-i:rr(2))=D;
        CC=C;
        Areconstruct=idct2(CC);
        diffimg=B-Areconstruct;
        diff=sum(sum(abs(diffimg)));
        Aint=uint8(Areconstruct);
        figure;imshow(A);
        title('lenna');
        figure;imshow(Aint);
        title('lenna_reconstruct');
    case 'cman'
        i=200;
        D=C(rr(1)-i:rr(1),rr(2)-i:rr(2));
        pp=8;
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
                        D(k,j)=0;
                    end
                end
            end
        end
        C(rr(1)-i:rr(1),rr(2)-i:rr(2))=D;
        CC=C;
        Areconstruct=idct2(CC);
        diffimg=B-Areconstruct;
        diff=sum(sum(abs(diffimg)));
        Aint=uint8(Areconstruct);
        figure;imshow(A);
        title('cman');
        figure;imshow(Aint);
        title('cman_reconstruct');
    case 'phantom'
        i=70;
        D=C(rr(1)-i:rr(1),rr(2)-i:rr(2));
        pp=83;
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
                        D(k,j)=0;
                    end
                end
            end
        end
        C(rr(1)-i:rr(1),rr(2)-i:rr(2))=D;
        CC=C;
        Areconstruct=idct2(CC);
        diffimg=B-Areconstruct;
        diff=sum(sum(abs(diffimg)));
        Aint=uint8(Areconstruct);
        figure;imshow(A);
        title('phantom');
        figure;imshow(Aint);
        title('phantom_reconstruct');
    case 'heart'
        i=165;
        o=80;
        D=C(rr(1)-i:rr(1),rr(2)-o:rr(2));
        pp=1;
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
                        D(k,j)=0;
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
end
        
% % lenna
% i=400;
% % cman
% i=200;
% % phantom
% i=70;
% % heart
% i=165; j=80;


