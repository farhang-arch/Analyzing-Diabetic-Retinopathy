%% Bsc Project: Image Contrast Enhancement Technique for Diabetic Retinopathy
clc
clear
close all

sampleImage = fullfile('images', 'sample image.jpg');
img=imread(sampleImage);
Ared=img(:,:,1); Agreen=img(:,:,2); Ablue=img(:,:,3);
imgred=im2double(Ared);
imggreen=im2double(Agreen);
imgblue=im2double(Ablue);
% creating the disk structuring element with width W
SE=strel('disk',15);
% bottom-hat morphological operation
imgredbottomhat=imbothat(imgred,SE); imggreenbottomhat=imbothat(imggreen,SE);
imgbluebottomhat=imbothat(imgblue,SE);
% negative operation
img_max=max(max(imggreenbottomhat));
imggreennew=img_max-imggreenbottomhat;
% denoising step
% imggreenden=swt_denoiser( f, 3, 'h', 'sym12' );
% imggreenden=universal_thresh( imggreennew, 2, 'db10', 20 );
imggreenden=proposed_denoising( imggreennew, 'db10' );
% contrast stretching
imgout=imadjust(imggreenden,stretchlim(imggreenden),[]);
% further enhancement
sigmoid=@(x,c,a) (1./(1+exp(-a.*(x-c))));
[c,k]=optimizer(imgout);
imgout_new=medfilt2(thresh_func(imgout,6,5,c+0.07));
% pade approximation
pad=@(x,c) (3125*(x-c).^6 + 13125*(x-c).^5 + 26250*(x-c).^4 + ...
    31500*(x-c).^3 + 23625*(x-c).^2 + 10395*(x-c) + 2079)./ ...
    (2*(3125*(x-c).^6 + 26250*(x-c).^4 + 23625*(x-c).^2 + 2079));
type=input('insert a type = ');
tic
switch type
    case 'sig_orig'
        imgout_new=sigmoid(imgout,c+0.1,10);
    case 'sig_pade_app'
        imgout_new=pad(imgout,c);
end
toc
% imwrite(ynew,'E:\paper1 code data\bsc_result\15_g.jpg')
originalvessel=impixel(imggreen);
originalbackground=impixel(imggreen);
% grayscale cef
origves=originalvessel(:,1)';
origback=originalbackground(:,1)';
n=length(origves);
cefden=(1/n)*abs(sum(origves)-sum(origback));
% Contrast Streching Based
enhancedvessely=impixel(imgout_new);
enhancedvesy=enhancedvessely(:,1)';
enhancedbackgroundy=impixel(imgout_new);
enhancedbacky=enhancedbackgroundy(:,1)';
cefnumy=(1/n)*abs(sum(enhancedvesy)-sum(enhancedbacky));
cefproposedy=cefnumy/cefden;

