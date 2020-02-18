clc
clear
close all

% conversion of colour channel into gray scale
img=imread('E:\paper1 code data\images\02_g.jpg');
Ared=img(:,:,1); Agreen=img(:,:,2); Ablue=img(:,:,3);
imgred=im2double(Ared);
imggreen=im2double(Agreen);
imgblue=im2double(Ablue);
% creating the disk structuring element with width W
SE0=strel('disk',15);
SE1=strel('disk',15);
% bottom hat morphological operation
imgredbottomhat=imbothat(Ared,SE0); imggreenbottomhat=imbothat(Agreen,SE0);
imgbluebottomhat=imbothat(Ablue,SE0);
% top hat morphological operation
imgredtophat=imtophat(Ared,SE1); imggreentophat=imtophat(Agreen,SE1);
imgbluetophat=imtophat(Ablue,SE1);
% (bottom-top) hat
imgrednew=im2double(imgredbottomhat)-im2double(imgredtophat);
imggreennew=im2double(imggreenbottomhat)-im2double(imggreentophat);
imgbluenew=im2double(imgbluebottomhat)-im2double(imgbluetophat);
% denoising
% imggreenden=swt_denoiser( imggreennew, 4, 's', 'sym12' );
imggreenden=universal_thresh( imggreennew, 3, 'sym12' );
% CLAHE
imgout=adapthisteq(imggreenden);
imgfiltered=medfilt2(imgout,[3 3]);

