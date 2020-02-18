% ---------------------  2D Process Wavelet  -----------------------

%%------------------------------image------------------------------
I=imread('heart.jpg');
w=zeros(size(I));
for i=1:size(I,1)
    for j=1:size(I,2)
        w(i,j)=I(i,j);
    end
end
[C,S]=wavedec2(w,3,'sym12');
S31=S(1,1)*S(1,2);
S21=S(3,1)*S(3,2);
S11=S(4,1)*S(4,2);
%--------------Set to Zero %k of  Min 2D Wavelet Coefficient-------------
% ------------ min to zero ----------------------------------------------
%------------- start level 1 -------------------------------------------
for pp=[98]
ue=C((((S21+(4*S31))+S21)+S21)+1:((((S21+(4*S31))+S21)+S21))+S11);
% ue=C(36118:59538);
zue=numel(ue)-nnz(ue);
be=sign(ue);
ue=ue.*be;
[me,ne]=size(ue);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
ue=ue.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=ue;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_ue=min(reve);
[re,ce]=find(ue==min_ue);
[t1,t2]=size(re);
for je=1:t1
    ue(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
ue=ue.*be;
C((((S21+(4*S31))+S21)+S21)+1:((((S21+(4*S31))+S21)+S21))+S11)=ue;
% C(36118:59538)=ue;
end


% ---------------------------------------------------------------------
qe=C((((((S21+(4*S31))+S21)+S21))+S11)+1:(((((S21+(4*S31))+S21)+S21))+S11)+S11);
% qe=C(59539:82959);
zue=numel(qe)-nnz(qe);
be=sign(qe);
qe=qe.*be;
[me,ne]=size(qe);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
qe=qe.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=qe;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_qe=min(reve);
[re,ce]=find(qe==min_qe);
[t1,t2]=size(re);
for je=1:t1
    qe(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
qe=qe.*be;
C((((((S21+(4*S31))+S21)+S21))+S11)+1:(((((S21+(4*S31))+S21)+S21))+S11)+S11)=qe;
end
% ------------------------------------------------------------------------

pe=C(((((((S21+(4*S31))+S21)+S21))+S11)+S11)+1:((((((S21+(4*S31))+S21)+S21))+S11)+S11)+S11);
zue=numel(pe)-nnz(pe);
be=sign(pe);
pe=pe.*be;
[me,ne]=size(pe);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
pe=pe.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=pe;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_pe=min(reve);
[re,ce]=find(pe==min_pe);
[t1,t2]=size(re);
for je=1:t1
    pe(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
pe=pe.*be;
C(((((((S21+(4*S31))+S21)+S21))+S11)+S11)+1:((((((S21+(4*S31))+S21)+S21))+S11)+S11)+S11)=pe;
end

%------------------- start level 2-----------------------------------------------
ue2=C(4*S31+1:S21+(4*S31));
zue=numel(ue2)-nnz(ue2);
be=sign(ue2);
ue2=ue2.*be;
[me,ne]=size(ue2);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
ue2=ue2.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=ue2;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_ue=min(reve);
[re,ce]=find(ue2==min_ue);
[t1,t2]=size(re);
for je=1:t1
    ue2(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
ue2=ue2.*be;
C(4*S31+1:S21+(4*S31))=ue2;
end


% ---------------------------------------------------------------------
qe2=C((S21+(4*S31))+1:(S21+(4*S31))+S21);
zue=numel(qe2)-nnz(qe2);
be=sign(qe2);
qe2=qe2.*be;
[me,ne]=size(qe2);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
qe2=qe2.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=qe2;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_qe=min(reve);
[re,ce]=find(qe2==min_qe);
[t1,t2]=size(re);
for je=1:t1
    qe2(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
qe2=qe2.*be;
C((S21+(4*S31))+1:(S21+(4*S31))+S21)=qe2;
end
% ------------------------------------------------------------

pe2=C(((S21+(4*S31))+S21)+1:((S21+(4*S31))+S21)+S21);
zue=numel(pe2)-nnz(pe2);
be=sign(pe2);
pe2=pe2.*be;
[me,ne]=size(pe2);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
pe2=pe2.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=pe2;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_pe=min(reve);
[re,ce]=find(pe2==min_pe);
[t1,t2]=size(re);
for je=1:t1
    pe2(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
pe2=pe2.*be;
C(((S21+(4*S31))+S21)+1:((S21+(4*S31))+S21)+S21)=pe2;
end


%--------------------level 3-------------------------------------------
ue3=C(S31+1:2*S31);
zue=numel(ue3)-nnz(ue3);
be=sign(ue3);
ue3=ue3.*be;
[me,ne]=size(ue3);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
ue3=ue3.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=ue3;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_ue=min(reve);
[re,ce]=find(ue3==min_ue);
[t1,t2]=size(re);
for je=1:t1
    ue3(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
ue3=ue3.*be;
C(S31+1:2*S31)=ue3;
end


% ---------------------------------------------------------------------
qe3=C(2*S31+1:3*S31);
zue=numel(qe3)-nnz(qe3);
be=sign(qe3);
qe3=qe3.*be;
[me,ne]=size(qe3);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
qe3=qe3.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=qe3;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_qe=min(reve);
[re,ce]=find(qe3==min_qe);
[t1,t2]=size(re);
for je=1:t1
    qe3(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
qe3=qe3.*be;
C(2*S31+1:3*S31)=qe3;
end
% ------------------------------------------------------------

pe3=C(3*S31+1:4*S31);
zue=numel(pe3)-nnz(pe3);
be=sign(pe3);
pe3=pe3.*be;
[me,ne]=size(pe3);
ke=ceil(((pp)*(me*ne)/100));
if zue>=ke
pe3=pe3.*be;
else
cnt=0;
cnt1=zue;

for ie=1:ke
ve=pe3;
vr=me*ne;
reve=reshape(ve,1,vr);
[vre,vce]=find(reve==0);
reve(vce)=[];
min_pe=min(reve);
[re,ce]=find(pe3==min_pe);
[t1,t2]=size(re);
for je=1:t1
    pe3(re(je),ce(je))=0;
    cnt=cnt+1;
    if cnt>=ke
    break
    end
end
cnt1=cnt1+t1;
if cnt1>=ke
break
end

end
pe3=pe3.*be;
C(3*S31+1:4*S31)=pe3;
end
%-----------------------------------------------------------------------
% maxw=max(max(w));
% w=w/maxw;

%------------------------------------------------------------------------
if pp==1
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage40=idwt2(lls1,qe,pe,ue,'haar');
zpimage1=waverec2(C,S,'sym12');
maxfx=max(max(zpimage1));
zpi=zpimage1/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 40% min wavelet coff.');
title('Lena-Reconstruct 1% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'1.jpg');
end

if pp==10
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage40=idwt2(lls1,qe,pe,ue,'haar');
zpimage10=waverec2(C,S,'sym12');
maxfx=max(max(zpimage10));
zpi=zpimage10/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 40% min wavelet coff.');
title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'10.jpg');
end

if pp==20
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage40=idwt2(lls1,qe,pe,ue,'haar');
zpimage20=waverec2(C,S,'sym12');
maxfx=max(max(zpimage20));
zpi=zpimage20/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 40% min wavelet coff.');
title('Lena-Reconstruct 20% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'20.jpg');
end

if pp==30
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage40=idwt2(lls1,qe,pe,ue,'haar');
zpimage30=waverec2(C,S,'sym12');
maxfx=max(max(zpimage30));
zpi=zpimage30/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 40% min wavelet coff.');
title('Lena-Reconstruct 30% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'30.jpg');
end

if pp==40
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage40=idwt2(lls1,qe,pe,ue,'haar');
zpimage40=waverec2(C,S,'sym12');
maxfx=max(max(zpimage40));
zpi=zpimage40/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 40% min wavelet coff.');
title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'40.jpg');
end

if pp==50
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage50=idwt2(lls1,qe,pe,ue,'haar');
zpimage50=waverec2(C,S,'sym12');
maxfx=max(max(zpimage50));
zpi=zpimage50/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 50% min wavelet coff.');
title('Lena-Reconstruct 50% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'50.jpg');
end
if pp==60
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage60=idwt2(lls1,qe,pe,ue,'haar');
zpimage60=waverec2(C,S,'sym12');
maxfx=max(max(zpimage60));
zpi=zpimage60/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 60% min wavelet coff.');
title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'60.jpg');
end

if pp==70
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage70=idwt2(lls1,qe,pe,ue,'haar');
zpimage70=waverec2(C,S,'sym12');
maxfx=max(max(zpimage70));
zpi=zpimage70/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 70% min wavelet coff.');
title('Lena-Reconstruct 30% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'70.jpg');
end

if pp==80
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage80=idwt2(lls1,qe,pe,ue,'haar');
zpimage80=waverec2(C,S,'sym12');
maxfx=max(max(zpimage80));
zpi=zpimage80/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 80% min wavelet coff.');
title('Lena-Reconstruct 20% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'80.jpg');
end

if pp==90
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage90=idwt2(lls1,qe,pe,ue,'haar');
zpimage90=waverec2(C,S,'sym12');
maxfx=max(max(zpimage90));
zpi=zpimage90/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 90% min wavelet coff.');
title('Lena-Reconstruct 10% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'90.jpg');
end

if pp==91
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage90=idwt2(lls1,qe,pe,ue,'haar');
zpimage91=waverec2(C,S,'sym12');
maxfx=max(max(zpimage91));
zpi=zpimage91/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 90% min wavelet coff.');
title('Lena-Reconstruct 9% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'91.jpg');
end

if pp==92
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage92=idwt2(lls1,qe,pe,ue,'haar');
zpimage92=waverec2(C,S,'sym12');
maxfx=max(max(zpimage92));
zpi=zpimage92/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 92% min wavelet coff.');
title('Lena-Reconstruct 8% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'92.jpg');
end

if pp==94
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage94=idwt2(lls1,qe,pe,ue,'haar');
zpimage94=waverec2(C,S,'sym12');
maxfx=max(max(zpimage94));
zpi=zpimage94/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 94% min wavelet coff.');
title('Lena-Reconstruct 6% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'94.jpg');
end

if pp==96
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage96=idwt2(lls1,qe,pe,ue,'haar');
zpimage96=waverec2(C,S,'sym12');
maxfx=max(max(zpimage96));
zpi=zpimage96/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 96% min wavelet coff.');
title('Lena-Reconstruct 4% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'96.jpg');
end

if pp==98
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage98=idwt2(lls1,qe,pe,ue,'haar');
zpimage98=waverec2(C,S,'sym12');
maxfx=max(max(zpimage98));
zpi=zpimage98/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 98% min wavelet coff.');
title('Lena-Reconstruct 2% max-High fre. wavelet coff.(100% LL1)');
% imwrite(zpi,'98.jpg');
end

if pp==99
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage99=idwt2(lls1,qe,pe,ue,'haar');
zpimage99=waverec2(C,S,'sym12');
maxfx=max(max(zpimage99));
zpi=zpimage99/maxfx;
figure;
imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 99% min wavelet coff.');
title('Lena-Reconstruct 1% max-High fre. wavelet coff.(100% LL1)');
imwrite(zpi,'99.jpg');
end

if pp==100
% lls2=idwt2(lls3,qe3,pe3,ue3,'haar');    
% lls1=idwt2(lls2,qe2,pe2,ue2,'haar');    
% zpimage100=idwt2(lls1,qe,pe,ue,'haar');
zpimage100=waverec2(C,S,'sym12');
maxfx=max(max(zpimage100));
zpi=zpimage100/maxfx;
figure;
imshow(zpi,[]);
title('coil 15-S 56 set to zero. 100% min wavelet coff.');
imwrite(zpi,'100.jpg');
end
allcoeff=
end

