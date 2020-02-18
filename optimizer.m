function [ topt, counter ] = optimizer( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
imgresh=img(:);
t(1)=(min(imgresh)+max(imgresh))/2;
j=2;
sumbot=0;
sumtop=0;
cnt=0;
for i=1:length(imgresh)
    if imgresh(i)<=t(1)
        sumbot=sumbot+imgresh(i);
        cnt=cnt+1;
    else
        sumtop=sumtop+imgresh(i);
    end
end
mubot=sumbot/cnt;
mutop=sumtop/(length(imgresh)-cnt);
t(j)=(mubot+mutop)/2;
delta(j-1)=abs(t(j)-t(j-1));
eps=delta(j-1)/100000;
counter=0;
while delta(j-1)>eps
    sumbot=0;
    sumtop=0;
    cnt=0;
    for i=1:length(imgresh)
        if imgresh(i)<=t(j)
            sumbot=sumbot+imgresh(i);
            cnt=cnt+1;
        else
            sumtop=sumtop+imgresh(i);
        end
    end
    mubot=sumbot/cnt;
    mutop=sumtop/(length(imgresh)-cnt);
    j=j+1;
    t(j)=(mubot+mutop)/2;
    delta(j-1)=abs(t(j)-t(j-1));
    counter=counter+1;
end
topt=t(end);
end

