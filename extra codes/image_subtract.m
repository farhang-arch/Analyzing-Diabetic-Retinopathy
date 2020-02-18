function [ imgout ] = image_subtract( img1, img2 )
% img1, img2 ==> two input int image
img1=im2double(img1);
img2=im2double(img2);
imgout=img1-img2;

end

