%---------------------- Expriment  -----------------------
%%------------------------------image------------------------------
A=imread('1.png');
w=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        w(i,j)=A(i,j);
    end
end
% ---------------------  2D Process Wavelet  -----------------------
[C,S]=wavedec2(w,1,'sym12');
totalenergy=sum(abs(C).^2);
% S31=S(1,1)*S(1,2);
% S21=S(3,1)*S(3,2);
S11=S(1,1)*S(1,2);
%--------------Set to Zero %k of  Min 2D Wavelet Coefficient-------------
% ------------ min to zero ----------------------------------------------
%------------- start level 1 -------------------------------------------
SR=zeros(1,4);
poi=1;

for pp=[96]
ue=C(1+S11:2*S11);
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
C(1+S11:2*S11)=ue;
% C(36118:59538)=ue;
end


% ---------------------------------------------------------------------
qe=C(1+2*S11:3*S11);
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
C(1+2*S11:3*S11)=qe;
end
% ------------------------------------------------------------------------

pe=C(1+3*S11:4*S11);
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
C(1+3*S11:4*S11)=pe;
end

remainenergy=sum(abs(C).^2);
energyratio=remainenergy/totalenergy;
%-------------------------- MSE ------------------------------------------

% if pp==1
% zpimage1=waverec2(C,S,'sym12');
% MD1=w-zpimage1;
% dwmad1=sum(sum(abs(MD1)));
% maxfx=max(max(zpimage1));
% zpi=zpimage1/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 1% max-High fre. wavelet coff.(100% LL1)');
% end
% 
% if pp==10
% zpimage10=waverec2(C,S,'sym12');
% MD10=w-zpimage10;
% dwmad10=sum(sum(abs(MD10)));
% maxfx=max(max(zpimage10));
% zpi=zpimage10/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'10.jpg');
% end
% 
% if pp==20
% zpimage20=waverec2(C,S,'sym12');
% MD20=w-zpimage20;
% dwmad20=sum(sum(abs(MD20)));
% maxfx=max(max(zpimage20));
% zpi=zpimage20/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 20% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'20.jpg');
% end
% 
% if pp==30
% zpimage30=waverec2(C,S,'sym12');
% MD30=w-zpimage30;
% dwmad30=sum(sum(abs(MD30)));
% maxfx=max(max(zpimage30));
% zpi=zpimage30/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 30% max-High fre. wavelet coff.(100% LL1)');
% imwrite(zpi,'E:\paper1 code data\results\30.jpg');
% end
% 
% if pp==40
% zpimage40=waverec2(C,S,'sym12');
% MD40=w-zpimage40;
% dwmad40=sum(sum(abs(MD40)));
% maxfx=max(max(zpimage40));
% zpi=zpimage40/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'40.jpg');
% end
% 
% if pp==50
% zpimage50=waverec2(C,S,'sym12');
% MD50=w-zpimage50;
% dwmad50=sum(sum(abs(MD50)));
% maxfx=max(max(zpimage50));
% zpi=zpimage50/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 50% max-High fre. wavelet coff.(100% LL1)');
% imwrite(zpi,'E:\paper1 code data\results\50.jpg');
% end
% 
% if pp==60
% zpimage60=waverec2(C,S,'sym12');
% MD60=w-zpimage60;
% dwmad60=sum(sum(abs(MD60)));
% maxfx=max(max(zpimage60));
% zpi=zpimage60/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 40% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'E:\paper1 code data\results\60wave.jpg');
% end
% 
% if pp==75
% zpimage75=waverec2(C,S,'sym12');
% MD75=w-zpimage75;
% dwmad75=sum(sum(abs(MD75)));
% maxfx=max(max(zpimage75));
% zpi=zpimage75/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 30% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'E:\paper1 code data\results\75wave.jpg');
% end
% 
% if pp==80
% zpimage80=waverec2(C,S,'sym12');
% MD80=w-zpimage80;
% dwmad80=sum(sum(abs(MD80)));
% maxfx=max(max(zpimage80));
% zpi=zpimage80/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 20% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'80.jpg');
% end
% 
% if pp==90
% zpimage90=waverec2(C,S,'sym12');
% MD90=w-zpimage90;
% dwmad90=sum(sum(abs(MD90)));
% maxfx=max(max(zpimage90));
% zpi=zpimage90/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 10% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'E:\paper1 code data\results\90wave.jpg');
% end
% 
% if pp==91
% zpimage91=waverec2(C,S,'sym12');
% MD91=w-zpimage91;
% dwmad91=sum(sum(abs(MD91)));
% maxfx=max(max(zpimage91));
% zpi=zpimage91/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 9% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'91.jpg');
% end
% 
% if pp==92
% zpimage92=waverec2(C,S,'sym12');
% MD92=w-zpimage92;
% dwmad92=sum(sum(abs(MD92)));
% maxfx=max(max(zpimage92));
% zpi=zpimage92/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 8% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'92.jpg');
% end
% 
% if pp==94
% zpimage94=waverec2(C,S,'sym12');
% MD94=w-zpimage94;
% dwmad94=sum(sum(abs(MD94)));
% maxfx=max(max(zpimage94));
% zpi=zpimage94/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 6% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'94.jpg');
% end
% 
% if pp==96
% zpimage96=waverec2(C,S,'sym12');
% MD96=w-zpimage96;
% dwmad96=sum(sum(abs(MD96)));
% maxfx=max(max(zpimage96));
% zpi=zpimage96/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 4% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'96.jpg');
% end
% 
% if pp==98
% zpimage98=waverec2(C,S,'sym12');
% MD98=w-zpimage98;
% dwmad98=sum(sum(abs(MD98)));
% maxfx=max(max(zpimage98));
% zpi=zpimage98/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 2% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'E:\paper1 code data\results\98wave.jpg');
% end
% 
% if pp==99
% zpimage99=waverec2(C,S,'sym12');
% MD99=w-zpimage99;
% dwmad99=sum(sum(abs(MD99)));
% maxfx=max(max(zpimage99));
% zpi=zpimage99/maxfx;
% figure;
% imshow(zpi,[]);
% title('Lena-Reconstruct 1% max-High fre. wavelet coff.(100% LL1)');
% % imwrite(zpi,'99.jpg');
% end
% 
% if pp==100
% zpimage100=waverec2(C,S,'sym12');
% MD100=w-zpimage100;
% dwmad100=sum(sum(abs(MD100)));
% maxfx=max(max(zpimage100));
% zpi=zpimage100/maxfx;
% figure;
% imshow(zpi,[]);
% title('coil 15-S 56 set to zero. 100% min wavelet coff.');
% % imwrite(zpi,'100.jpg');
% end


allcoeff=4*S11;
remaincoeff=S11+3*(1-pp/100)*S11;
sparsity_ratio=remaincoeff/allcoeff;
SR(poi)=sparsity_ratio;
poi=poi+1;
end

