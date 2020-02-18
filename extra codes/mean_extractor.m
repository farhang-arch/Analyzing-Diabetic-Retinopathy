function [ imgout ] = mean_extractor( img, l, k )
% img is input image
% l, k size of windowing operation
fun=@(x) mean(x(:));
avg=nlfilter(img, [l k], fun);
imgout=zeros(size(img));
for i=1:size(img,1)
    for j=1:size(img,2)
        if avg(i,j)-img(i,j)>0
            imgout(i,j)=avg(i,j)-img(i,j);
        else
            imgout(i,j)=0;
        end
    end
end
end

