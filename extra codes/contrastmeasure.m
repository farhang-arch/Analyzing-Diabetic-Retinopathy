function cef = contrastmeasure( img, method )
% inputs
% img: input image
% method: 1-histogram equalisation (hist)
% 2-contrast limited adaptive histogram equalisation (adapt hist)
% output
imggreen=im2double(img(:,:,2));
switch method
    case 'hist'
        originalvessel=impixel(imggreen);
        originalbackground=impixel(imggreen);
        % grayscale cef
        origves=originalvessel(:,1)';
        origback=originalbackground(:,1)';
        n=length(origves);
        cefden=(1/n)*abs(sum(origves)-sum(origback));
        imghist=histeq(imggreen);
        enhancedvessel=impixel(imghist);
        enhancedves=enhancedvessel(:,1)';
        enhancedbackground=impixel(imghist);
        enhancedback=enhancedbackground(:,1)';
%         n=length(enhancedves);
        cefnum=(1/n)*abs(sum(enhancedves)-sum(enhancedback));
        cef=cefnum/cefden;
    case 'adaptive hist'
        originalvessel=impixel(imggreen);
        originalbackground=impixel(imggreen);
        % grayscale cef
        origves=originalvessel(:,1)';
        origback=originalbackground(:,1)';
        n=length(origves);
        cefden=(1/n)*abs(sum(origves)-sum(origback));
        imgadapthist=adapthisteq(imggreen);
        enhancedvessel=impixel(imgadapthist);
        enhancedves=enhancedvessel(:,1)';
        enhancedbackground=impixel(imgadapthist);
        enhancedback=enhancedbackground(:,1)';
%         n=length(enhancedves);
        cefnum=(1/n)*abs(sum(enhancedves)-sum(enhancedback));
        cef=cefnum/cefden;
end
end

