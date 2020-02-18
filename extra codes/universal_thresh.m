function [ imgout ] = universal_thresh( img, nlevel, filt, r )
%   UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nlevel==1
    [a,b,c,d]=dwt2(img,filt);
    sb=median(abs(b(:)))/0.6745;
    threshb=sqrt(2*log(numel(img)))*sb;
    sc=median(abs(c(:)))/0.6745;
    threshc=sqrt(2*log(numel(img)))*sc;
    sd=median(abs(d(:)))/0.6745;
    threshd=sqrt(2*log(numel(img)))*sd;
    bhat=trsh(b-threshb,1,r)-trsh(-b-threshb,1,r);
%     bhat=wthresh(b,'s',threshb);
    chat=trsh(c-threshc,1,r)-trsh(-c-threshc,1,r);
%     chat=wthresh(c,'s',threshc);
    dhat=trsh(d-threshd,1,r)-trsh(-d-threshd,1,r);
%     dhat=wthresh(d,'s',threshd);
    imgout=idwt2(a,bhat,chat,dhat,filt);
elseif nlevel==2
    [c,s]=wavedec2(img, nlevel, filt);
    s2=s(1,1)*s(1,2);
    s1=s(3,1)*s(3,2);
    b2=c(s2+1:2*s2); c2=c(2*s2+1:3*s2); d2=c(3*s2+1:4*s2);
    b1=c(4*s2+1:4*s2+s1); c1=c(4*s2+s1+1:4*s2+2*s1); d1=c(4*s2+2*s1+1:4*s2+3*s1);
    sb1=median(abs(b1))/0.6745; sc1=median(abs(c1))/0.6745; sd1=median(abs(d1))/0.6745;
    threshb1=sqrt(2*log(numel(img)))*sb1;
    threshc1=sqrt(2*log(numel(img)))*sc1;
    threshd1=sqrt(2*log(numel(img)))*sd1;
    sb2=median(abs(b2))/0.6745; sc2=median(abs(c2))/0.6745; sd2=median(abs(d2))/0.6745;
    threshb2=sqrt(2*log(numel(img)))*sb2;
    threshc2=sqrt(2*log(numel(img)))*sc2;
    threshd2=sqrt(2*log(numel(img)))*sd2;
    b1hat=trsh(b1-threshb1,1,r)-trsh(-b1-threshb1,1,r);
%     b1hat=wthresh(b1,'h',threshb1);
    c1hat=trsh(c1-threshc1,1,r)-trsh(-c1-threshc1,1,r);
%     c1hat=wthresh(c1,'h',threshc1);
    d1hat=trsh(d1-threshd1,1,r)-trsh(-d1-threshd1,1,r);
%     d1hat=wthresh(d1,'h',threshd1);
    b2hat=trsh(b2-threshb2,1,r)-trsh(-b2-threshb2,1,r);
%     b2hat=wthresh(b2,'h',threshb2);
    c2hat=trsh(c2-threshc2,1,r)-trsh(-c2-threshc2,1,r);
%     c2hat=wthresh(c2,'h',threshc2);
    d2hat=trsh(d2-threshd2,1,r)-trsh(-d2-threshd2,1,r);
%     d2hat=wthresh(d2,'h',threshd2);
    c(4*s2+1:4*s2+s1)=b1hat; c(4*s2+s1+1:4*s2+2*s1)=c1hat; c(4*s2+2*s1+1:4*s2+3*s1)=d1hat;
    c(s2+1:2*s2)=b2hat; c(2*s2+1:3*s2)=c2hat; c(3*s2+1:4*s2)=d2hat;
    imgout=waverec2(c,s,filt);
elseif nlevel==3
    [c,s]=wavedec2(img, nlevel, filt);
    s3=s(1,1)*s(1,2);
    s2=s(3,1)*s(3,2);
    s1=s(4,1)*s(4,2);
    b3=c(s3+1:2*s3); c3=c(2*s3+1:3*s3); d3=c(3*s3+1:4*s3);
    b2=c(4*s3+1:4*s3+s2); c2=c(4*s3+s2+1:4*s3+2*s2); d2=c(4*s3+2*s2+1:4*s3+3*s2);
    b1=c(4*s3+3*s2+1:4*s3+3*s2+s1); c1=c(4*s3+3*s2+s1+1:4*s3+3*s2+2*s1); d1=c(4*s3+3*s2+2*s1+1:4*s3+3*s2+3*s1);
    sb1=median(abs(b1))/0.6745; sc1=median(abs(c1))/0.6745; sd1=median(abs(d1))/0.6745;
    threshb1=sqrt(2*log(numel(img)))*sb1;
    threshc1=sqrt(2*log(numel(img)))*sc1;
    threshd1=sqrt(2*log(numel(img)))*sd1;
    sb2=median(abs(b2))/0.6745; sc2=median(abs(c2))/0.6745; sd2=median(abs(d2))/0.6745;
    threshb2=sqrt(2*log(numel(img)))*sb2;
    threshc2=sqrt(2*log(numel(img)))*sc2;
    threshd2=sqrt(2*log(numel(img)))*sd2;
    sb3=median(abs(b3))/0.6745; sc3=median(abs(c3))/0.6745; sd3=median(abs(d3))/0.6745;
    threshb3=sqrt(2*log(numel(img)))*sb3;
    threshc3=sqrt(2*log(numel(img)))*sc3;
    threshd3=sqrt(2*log(numel(img)))*sd3;
    b1hat=wthresh(b1,'h',threshb1);
    c1hat=wthresh(c1,'h',threshc1);
    d1hat=wthresh(d1,'h',threshd1);
    b2hat=wthresh(b2,'h',threshb2);
    c2hat=wthresh(c2,'h',threshc2);
    d2hat=wthresh(d2,'h',threshd2);
    b3hat=wthresh(b3,'h',threshb3);
    c3hat=wthresh(c3,'h',threshc3);
    d3hat=wthresh(d3,'h',threshd3);
    c(4*s3+3*s2+1:4*s3+3*s2+s1)=b1hat; c(4*s3+3*s2+s1+1:4*s3+3*s2+2*s1)=c1hat; c(4*s3+3*s2+2*s1+1:4*s3+3*s2+3*s1)=d1hat;
    c(4*s3+1:4*s3+s2)=b2hat; c(4*s3+s2+1:4*s3+2*s2)=c2hat; c(4*s3+2*s2+1:4*s3+3*s2)=d2hat;
    c(s3+1:2*s3)=b3hat; c(2*s3+1:3*s3)=c3hat; c(3*s3+1:4*s3)=d3hat;
    imgout=waverec2(c,s,filt);
end
end

