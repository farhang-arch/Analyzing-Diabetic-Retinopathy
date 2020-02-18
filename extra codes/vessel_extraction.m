function [imgout, counter] = vessel_extraction( img, s )
% img must be a 24 bit image.
% 's' is a selector between 'green-band' and 'gray'
switch s
    case 'green-band'
        % imgred=im2double(img(:,:,1));
        imggreen=im2double(img(:,:,2));
        % imgblue=im2double(img(:,:,3));
        % contrast enhancement
        imggreennew=adapthisteq(imggreen, 'NumTiles', [8 8], 'NBins', 128);
        % background exclusion
        fun=@(x) mean(x(:));
        imggreenavg=nlfilter(imggreennew, [14 14], fun);
        imggreenout=zeros(size(imggreennew));
        for i=1:size(imggreennew,1)
            for j=1:size(imggreennew,2)
                if imggreenavg(i,j)-imggreennew(i,j)>0
                    imggreenout(i,j)=imggreenavg(i,j)-imggreennew(i,j);
                else
                    imggreenout(i,j)=0;
                end
            end
        end
        imggreenout=medfilt2(imggreenout,[6 6]);
%         imggreenout=wiener2(imggreenout,[3 3]);
        % thresholding and create binary image
        imggreenresh=imggreenout(:);
        t(1)=(min(imggreenresh)+max(imggreenresh))/2;
        j=2;
        sumbot=0;
        sumtop=0;
        cnt=0;
        for i=1:length(imggreenresh)
            if imggreenresh(i)<=t(1)
                sumbot=sumbot+imggreenresh(i);
                cnt=cnt+1;
            else
                sumtop=sumtop+imggreenresh(i);
            end
        end
        mubot=sumbot/cnt;
        mutop=sumtop/(length(imggreenresh)-cnt);
        t(j)=(mubot+mutop)/2;
        delta(j-1)=abs(t(j)-t(j-1));
        eps=delta(j-1)/100;
        counter=0;
        while delta(j-1)>eps
            sumbot=0;
            sumtop=0;
            cnt=0;
            for i=1:length(imggreenresh)
                if imggreenresh(i)<=t(j)
                    sumbot=sumbot+imggreenresh(i);
                    cnt=cnt+1;
                else
                    sumtop=sumtop+imggreenresh(i);
                end
            end
            mubot=sumbot/cnt;
            mutop=sumtop/(length(imggreenresh)-cnt);
            j=j+1;
            t(j)=(mubot+mutop)/2;
            delta(j-1)=abs(t(j)-t(j-1));
            counter=counter+1;
        end
        topt=t(end);
        for i=1:size(imggreenout,1)
            for j=1:size(imggreenout,2)
                if imggreenout(i,j)>=topt
                    imggreenout(i,j)=1;
                else
                    imggreenout(i,j)=0;
                end
            end
        end
        imgout=imggreenout;
        SE=strel('disk',1);
        imgout=imclose(imgout,SE);
% imggreenfiltered=medfilt2(imggreenout,[2 2]);
% for i=1:size(imggreenfiltered,1)
%     for j=1:size(imggreenfiltered,2)
%         if imggreenfiltered(i,j)==0.5
%             imggreenfiltered(i,j)=1;
%         end
%     end
% end
% SE=strel('disk',1);
% imggreenmorph=imclose(imggreenout,SE);
% imgout=imggreenmorph;
    case 'gray'
        imgred=im2double(img(:,:,1));
        imggreen=im2double(img(:,:,2));
        imgblue=im2double(img(:,:,3));
        imggray=0.2989*imgred+0.5870*imggreen+0.1140*imgblue;
        % contrast enhancement
        imggraynew=adapthisteq(imggray, 'NumTiles', [8 8], 'NBins', 256);
        % background exclusion
        fun=@(x) mean(x(:));
        imggrayavg=nlfilter(imggraynew, [9 9], fun);
        imggrayout=zeros(size(imggraynew));
        for i=1:size(imggraynew,1)
            for j=1:size(imggraynew,2)
                if imggrayavg(i,j)-imggraynew(i,j)>0
                    imggrayout(i,j)=imggrayavg(i,j)-imggraynew(i,j);
                else
                    imggrayout(i,j)=0;
                end
            end
        end
        % thresholding and create binary image
        imggrayresh=imggrayout(:);
        t(1)=(min(imggrayresh)+max(imggrayresh))/2;
        j=2;
        sumbot=0;
        sumtop=0;
        cnt=0;
        for i=1:length(imggrayresh)
            if imggrayresh(i)<=t(1)
                sumbot=sumbot+imggrayresh(i);
                cnt=cnt+1;
            else
                sumtop=sumtop+imggrayresh(i);
            end
        end
        mubot=sumbot/cnt;
        mutop=sumtop/(length(imggrayresh)-cnt);
        t(j)=(mubot+mutop)/2;
        delta(j-1)=abs(t(j)-t(j-1));
        eps=delta(j-1)/500;
        counter=0;
        while delta(j-1)>eps
            sumbot=0;
            sumtop=0;
            cnt=0;
            for i=1:length(imggrayresh)
                if imggrayresh(i)<=t(j)
                    sumbot=sumbot+imggrayresh(i);
                    cnt=cnt+1;
                else
                    sumtop=sumtop+imggrayresh(i);
                end
            end
            mubot=sumbot/cnt;
            mutop=sumtop/(length(imggrayresh)-cnt);
            j=j+1;
            t(j)=(mubot+mutop)/2;
            delta(j-1)=abs(t(j)-t(j-1));
            counter=counter+1;
        end
        topt=t(end);
        for i=1:size(imggrayout,1)
            for j=1:size(imggrayout,2)
                if imggrayout(i,j)>=topt
                    imggrayout(i,j)=1;
                else
                    imggrayout(i,j)=0;
                end
            end
        end
        imgout=imggrayout;
end
end

