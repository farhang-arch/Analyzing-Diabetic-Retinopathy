clc
clear
close all

img=imread('E:\paper1 code data\images\08_g.jpg');
imggreen=im2double(img(:,:,2));
imwrite(imggreen,'E:\paper1 code data\bsc_result\green band\08_g.jpg')
he=histeq(imggreen);
imwrite(he,'E:\paper1 code data\bsc_result\HE\08_g.jpg')
adapthe=adapthisteq(imggreen);
imwrite(adapthe,'E:\paper1 code data\bsc_result\CLAHE\08_g.jpg')
adj=imadjust(imggreen,stretchlim(imggreen),[]);
imwrite(adj,'E:\paper1 code data\bsc_result\contrast streching\08_g.jpg')