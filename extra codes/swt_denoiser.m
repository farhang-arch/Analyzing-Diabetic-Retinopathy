function out = swt_denoiser( img, level, character, wname )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[CA,CH,CV,CD]=swt2(img,level,wname);
for i=1:level
    % h denoising
    h=CH(:,:,i);
    sigmah=(median(abs(h(:)))/0.6745);
    Lh=i; Kh=2; Mh=2*(Lh-Kh);
    AMh=(1/numel(h))*sum(sum(abs(h)));
    GMh=prod(prod(abs(h)))^(1/numel(h));
    th=abs(Mh*(sigmah-(AMh-GMh)));
    h=wthresh(h,character,th);
    CH(:,:,i)=h;
    % v denoising
    v=CV(:,:,i);
    sigmav=(median(abs(v))/0.6745);
    Lv=i; Kv=3; Mv=2*(Lv-Kv);
    AMv=(1/numel(v))*sum(sum(abs(v)));
    GMv=prod(prod(abs(v)))^(1/numel(v));
    tv=abs(Mv*(sigmav-(AMv-GMv)));
    v=wthresh(v,character,tv);
    CV(:,:,i)=v;
    % d denoising
    d=CD(:,:,i);
    sigmad=(median(abs(d(:)))/0.6745);
    Ld=i; Kd=4; Md=2*(Ld-Kd);
    AMd=(1/numel(d))*sum(sum(abs(d)));
    GMd=prod(prod(abs(d)))^(1/numel(d));
    td=abs(Md*(sigmad-(AMd-GMd)));
    d=wthresh(d,character,td);
    CD(:,:,i)=d;
    out=iswt2(CA,CH,CV,CD,wname);
end

