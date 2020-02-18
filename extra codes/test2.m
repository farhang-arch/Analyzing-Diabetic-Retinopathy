clc
clear;
close all;

im = imread('lena1.jpg');
img = double(im);
im1 = log(img); %low contrast image
% figure;
% imshow(im)
% figure;
% imshow(im1,[])n
[cA,cH,cV,cD] = dwt2(img,'bior2.2');
% figure;
% imshow(cA,[])
[cA1,cH1,cV1,cD1] = dwt2(cA,'bior2.2');
% figure;
% imshow(cA1,[])
figure;histogram(img,512)
figure;histogram(cA1,512)

% his = histeq(cA);
% img_enhanced = idwt2(his,cH,cV,cD,'bior2.2');
% figure;
% subplot(1,2,1)
% imshow(img_enhanced,[])
% subplot(1,2,2)
% imshow(img,[])


%mean and standard deviation test:
mean_im = mean(mean(img));
mean_scale1 = mean(mean(cA));
mean_scale2 = mean(mean(cA1));
std_im = std(std(img));
std_scale1 = std(std(cA));
std_scale2 = std(std(cA1));


Imax = max(max(im));
minbound = (2^2)*Imax*(-11/16);
maxbound = (2^2)*Imax*(35/16);

figure;
subplot(1,2,1)
imhist(im)
title('image histogram')
subplot(1,2,2)
imhist(cA1,[])
title('scaling coeff after 2 levels')
