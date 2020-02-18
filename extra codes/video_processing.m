clc
clear
close all

% video processing in MATLAB;
xyloObj = VideoReader('xylophone.mp4');
vidWidth = xyloObj.Width;
vidHeight = xyloObj.Height;
mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
mov_n=struct('cdata',zeros(vidHeight,vidWidth),...
    'colormap',[]);
noisy_version=struct('cdata',zeros(vidHeight,vidWidth),...
    'colormap',[]);
denoised_version=struct('cdata',zeros(vidHeight,vidWidth),...
    'colormap',[]);
sigma=0.2;
k = 1;
while hasFrame(xyloObj)
    mov(k).cdata = readFrame(xyloObj);
    k = k+1;
end
% make all frames gray so to create a black and white movie;
for Frame_counter=1:k-1
    mov_n(Frame_counter).cdata=im2double(rgb2gray(mov(Frame_counter).cdata));
    noisy_version(Frame_counter).cdata=mov_n(Frame_counter).cdata+...
        sigma*randn(vidHeight,vidWidth);
end
implay(noisy_version)
% denoising step
for Frame_counter=1:k-1
    img=noisy_version(Frame_counter).cdata;
    imgden=universal_thresh( img, 2, 'db10' );
    denoised_version(Frame_counter).cdata=imgden;
end
implay(denoised_version)

