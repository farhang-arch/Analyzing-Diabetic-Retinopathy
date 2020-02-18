%---------------------- Expriment  -----------------------
%%------------------------------image------------------------------
A=imread('0.bmp');
w=zeros(size(A));
for i=1:size(A,1)
    for j=1:size(A,2)
        w(i,j)=A(i,j);
    end
end
X=w;
%fdct_wrapping----------------------------------------------------------
C = fdct_wrapping(X,1,1,2,16);
cz=C;
curve1=curve_array( cz );
totalenergy=sum(abs(curve1).^2);
nSR=zeros(1,4);

% ------------ min to zero ----------------------------------------------
for pp=[98]
 for kk=1:16
ue=cz{1,2}{1,kk}(:,:);
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
end
cz{1,2}{1,kk}=ue;
 end
 
% ifdct_wrapping----------------------------------------------------------
curve2=curve_array( cz );
remainenergy=sum(abs(curve2).^2);
energyratio=remainenergy/totalenergy;
[M,N]=size(X);
FX = ifdct_wrapping(cz,1,M,N);
% maxw=max(max(w));
% w=w/maxw;

%---------------Result & Figure-----------------------------------------
% if pp==1
% FX1=FX;
% MD1=w-FX1;
% dcmad1=sum(sum(abs(MD1)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 1% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\1curve.jpg');
% end
% 
% 
% 
% if pp==10
% FX10=FX;
% MD10=w-FX10;
% dcmad10=sum(sum(abs(MD10)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 10% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\10curve.jpg');
% end
%  
% 
% if pp==20
% FX20=FX;
% MD20=w-FX20;
% dcmad20=sum(sum(abs(MD20)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 20% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\20curve.jpg');
% end
% 
% if pp==39
% FX39=FX;
% MD39=w-FX39;
% dcmad39=sum(sum(abs(MD39)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 30% min Curvelet Coeff. ');
% % imwrite(FX,'E:\paper1 code data\results\30curve.jpg');
% end
% 
% if pp==40
% FX40=FX;
% MD40=w-FX40;
% dcmad40=sum(sum(abs(MD40)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 40% min Curvelet Coeff. ');
% % imwrite(FX,'E:\paper1 code data\results\40curve.jpg');
% end
% 
% if pp==50
% FX50=FX;
% MD50=w-FX50;
% dcmad50=sum(sum(abs(MD50)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 50% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\50_lenna_curve.jpg');
% end
% 
% if pp==64
% FX60=FX;
% MD60=w-FX60;
% dcmad60=sum(sum(abs(MD60)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 60% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\64_heart_curve.jpg');
% end
% 
% if pp==75
% FX75=FX;
% MD75=w-FX75;
% dcmad75=sum(sum(abs(MD75)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 70% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\75_lenna_curve.jpg');
% end
% 
% if pp==80
% FX80=FX;
% MD80=w-FX80;
% dcmad80=sum(sum(abs(MD80)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title('Coil 15-S 56. set to Zero. 80% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\80curve.jpg');
% end
% 
% if pp==90
% FX90=FX;
% MD90=w-FX90;
% dcmad90=sum(sum(abs(MD90)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 90% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\90_lenna_curve.jpg');
% end
% 
% if pp==91
% FX91=FX;
% MD91=w-FX91;
% dcmad91=sum(sum(abs(MD91)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 91% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\91curve.jpg');
% end
% 
% if pp==92
% FX92=FX;
% MD92=w-FX92;
% dcmad92=sum(sum(abs(MD92)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 92% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\92curve.jpg');
% end
% 
% if pp==94
% FX94=FX;
% MD94=w-FX94;
% dcmad94=sum(sum(abs(MD94)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 94% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\94curve.jpg');
% end
% 
% if pp==96
% FX96=FX;
% MD96=w-FX96;
% dcmad96=sum(sum(abs(MD96)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 96% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\96curve.jpg');
% end
% 
% if pp==98
% FX98=FX;
% MD98=w-FX98;
% dcmad98=sum(sum(abs(MD98)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 98% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\98_lenna_curve.jpg');
% end
% 
% if pp==99
% FX99=FX;
% MD99=w-FX99;
% dcmad99=sum(sum(abs(MD99)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 99% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\99curve.jpg');
% end
% 
% if pp==100
% FX100=FX;
% MD100=w-FX100;
% dcmad100=sum(sum(abs(MD100)));
% maxfx=max(max(FX));
% FX=FX/maxfx;
% figure;
% imshow(FX,[]);
% title(' set to Zero. 100% min Curvelet Coeff. ');
% imwrite(FX,'E:\paper1 code data\results\100curve.jpg');
% end
end

