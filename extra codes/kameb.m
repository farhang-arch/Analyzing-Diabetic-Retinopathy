clear all
close all


M=2;
K=2;
L=[1 1];

jay=zeros(2^(M*K),M*K);
smk=zeros(M,K,2^(M*K));

for i=1:2^(M*K)
    for j=1:M*K
        if j==1
        jay(i,j)=mod(i-1,2);
        else
        jay(i,j)=(mod(i-1,2^j)-mod(i-1,2^(j-1)))/2^(j-1);
        end
    end
end
R=zeros(2^(M*K),M,K);

for i=1:2^(M*K)
R(i,:,:)=reshape((jay(i,:)),[M K]);
end


for rr=1:2^(M*K)
    for mm=1:M
        for kk=1:K
        smk(mm,kk,rr)=R(rr,mm,kk)
        end
    end
end

for rr=1:2^(M*K)
    for mm=1:M
        for jj= 
        smk(mm,jj,rr)=R(rr,mm,jj)
        end
    end
end
% 
% algorithm 1
% 
% h=zeros(1,2^(M*K));
% 
%         for rr=1:2^(M*K)
%             h(rr)=1;
%             for mm=1:M
%                if sum(smk(mm,:,rr))==L(mm)
%                 h(rr)=1*h(rr);
%                else
%                 h(rr)=0;
%                end
%             end
%             
%              for kk=1:K
%                  if sum(smk(:,kk,rr))==1
%                   h(rr)=1*h(rr);
%                  else
%                   h(rr)=0;
%                  end
%              end
%  
% r = 0; % Radius
% t = 2*pi;  % Angle
% data1 = [r.*cos(t), r.*sin(t)]; % Points
% Generate 25 points uniformly distributed in the annulus.
% r2 = sqrt(8*rand(9,1)+1); % Radius
% t2 = 2*pi*rand(9,1);      % Angle
% data2 = [r2.*cos(t2), r2.*sin(t2)]% points
% Plot the points, and plot circles of radii 1 and 2 for comparison.
% 
% figure;
% plot(data1(:,1),data1(:,2),'r.','MarkerSize',20);
% hold on
% figure;
% plot(data2(:,1),data2(:,2),'b.','MarkerSize',15);
% ezpolar(@(x)1); %Radius 1 
% ezpolar(@(x)5); %Radius 3 
% axis equal
% hold off
% K=6;
% M=3;
% k=[1:K];
% m=[1:M];
% L=[2, 3, 1];
% pnoise=10^(-0.5);
% P=10^(-3)*(10^(3));
% nk=1;
% Pc=[10:40];
% Pc=10.^(Pc/10)*10^(-3);
% P_mmax = 10^(-3)*(10^(4));
% P_kmin = 10^(-3)*10;
% P_mn= 2*P /M ; 
%  P_mo = P_mn ;
% 
% A=size(data2)
% B=repmat(data1,A(1),A(2)/2);
% for k=1:6
%     XD(k)=data2(k,1);
%     YD(k)=data2(k,2);
%     XBS(k)=B(k,1);
%     YBS(k)=B(k,2);
%     
%     d(k) = sqrt((XD(k)-XBS(k)).^2+(YD(k)-YBS(k)).^2);
%    
% 
% end
%    W= sort(d);
%   h{m(1)}=abs(((W(1:2)).^(-0.3)*10^(-3))/pnoise).^2;
%   h{m(2)}=abs(((W(3:5)).^(-0.3)*10^(-3))/pnoise).^2;
%   h{m(3)}=abs(((W(6)).^(-0.3)*10^(-3))/pnoise).^2;
%   h{m(4)}=abs(((W(7:8)).^(-0.3)*10^(-3))/pnoise).^2;
%   h{m(5)}=abs(((W(9)).^(-0.3)*10^(-3))/pnoise).^2;
% 
% for m=1: M   
%     if L(m) == 1
%         Mo = m
%     elseif L(m) > 1
%         Mn = m
%     end
% end
% 
% for j= 1 : K
%     for i= 1 :  K
%         zz=find(W(j) == d(i))
%         kk(j)=zz
%     end
% end
% L1=L(1);
% L2=L(2);
% L3=L(3);
% L4=L(4);
% L5=L(5);
% k{1}=kk(1:L1);
% k{2}=kk(L1+1:L1+L2);
% k{3}=kk(L1+L2+1:L1+L2+L3); 
% k{4}=kk(L1+L2+L3+1:L1+L2+L3+L4);
% k{5}=kk(L1+L2+L3+L4+1:L1+L2+L3+L4+L5);
% 
% Ao=[];
% for i=1:5
%     if L(i)==1
%         Ao=[Ao k{i}];
%     end
% end
% An=[];
% for i=1:5
%     if L(i)~=1
%         An=[An k{i}];
%     end
% end
% 
% for j= An(1) : length(An)
%     for mn=Mn(1):length(Mn)
%         for kn=An(1):length(An)
%             if h{mn}(j) > h{mn}(kn)
%                J(j) = j  ;
%             end
%         end
%     end
% end
% for mn = Mn(1) : Mn(length(Mn))
%     for j= J(1) : J(length(J))
%         for k=1:K
%             for m=1:M
%                 I_kmn = sum(Smnk.*Smnj.*p(j,mn)*(h{m}(k)))
%             end
%         end
%     end
% end
% 
% 
% R_kn1=log2((S1*P_kmn.*g)./(sum((I_kmn.*g)+sigma)));
% R_kn1(k,m)= -rel_entr(sum((I_kmn.*g)+sigma), (S1*p(k,m).*g));
% R_ko1=log2((S1*P_kmo.*g)./sigma);
% R_ko1(k,m)= -rel_entr(sigma, (S1*p(k,m).*g));
%  R_kmo(k,m)=log2((beta_km(k,m)*P_kmn(k,m).*g)./(sum((Ikmn.*g)+sigma)));
% R_kmo(k,m)= -rel_entr(sum((Ikmn.*g)+sigma), (beta_km(k,m)*P_kmn(k,m).*g));
% 
% 
% for n=1:Nperm
%     cvx_brgin
%    variable smk
%    maximize  (-rel_entr(sigma, (smk*p(k,m).*g)) - rel_entr(sum((I_kmn.*g)+sigma), (smk*p(k,m).*g))) \(sum(p(k,m))+Pc)
%     subject to
%     
%     
%         for rr=1:2^(M*K)
%             h(rr)=1;
%             for mm=1:M
%                if sum(smk(mm,:,rr))==L(mm)
%                 h(rr)=1*h(rr);
%                else
%                 h(rr)=0;
%                end
%             end
%             
%              for kk=1:K
%                  if sum(smk(:,kk,rr))==1
%                   h(rr)=1*h(rr);
%                  else
%                   h(rr)=0;
%                  end
%              end
%         end
%         
%     for k=1 : Am
%         for m=1 : M
%             sum(p(k,m)) <= P
%         end
%     end
%     for k =An(1): length(An) 
%         for k =Mn(1): length(Mn) 
%             P(k,m) >= P_kmin
%         end
%     end
%     for  k=An(1): length(An) 
%     sum (P(k,m)) <= P_mmax 
%     end
%     
%     for k =An(1): length(An) 
%     sum(smk*p(k,m),2) >= P_kmin
% end
% for k =Mn(1): length(Mn)
%     sum (smk*p(k,m)) <= P_mmax
% end
% 
%     Snew= cvx_optval;
% end
%             moadelat marboot be p?
%             
%             if h(rr)==0
%                 
%                 
%                 algorithm2
%                 
%                 
%             end
%             
%             
%             
%             
%         end
%         sum(h)