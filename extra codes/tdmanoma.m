

clear all
clc
close all
r = 0; % Radius
t = 2*pi;  % Angle
data1 = [r.*cos(t), r.*sin(t)]; % Points
%Generate 25 points uniformly distributed in the annulus.
r2 = sqrt(8*rand(10,1)+1); % Radius
t2 = 2*pi*rand(10,1);      % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]% points
%Plot the points, and plot circles of radii 1 and 2 for comparison.

figure;
plot(data1(:,1),data1(:,2),'r.','MarkerSize',20)
hold on
% figure;
plot(data2(:,1),data2(:,2),'b.','MarkerSize',15)
ezpolar(@(x)1); %Radius 1 
ezpolar(@(x)5); %Radius 3 
axis equal
hold off
pnoise=10^(-11.7)*10^(-3);
pc=10^(-4);
nk=.9;

Tmax=.1;

pe=[28:100];
pe=10.^(pe/10)*10^(-3);
A=size(data2)
B=repmat(data1,A(1),A(2)/2)

for i=1:10 
    for k=1:length(pe)
    XD(i)=data2(i,1);
    YD(i)=data2(i,2);
    
    XBS(i)=B(i,1);
    YBS(i)=B(i,2);
    d(i) = sqrt((XD(i)-XBS(i)).^2+(YD(i)-YBS(i)).^2);
    g(i)=1./d(i).^2.2*10^(-3);
g(i)=g(i)/pnoise;
h(i)=1./((d(i)).^2.2*10^(3));
R1(k)=throughput2(pe(k),pc,nk,pnoise,Tmax,g(i),h(i));
R2(k)=throughput(pe(k),pc,nk,pnoise,Tmax,g(i),h(i));
    end
end
pe=pe*10^(3);
pe=10*log10(pe);
figure;
plot(pe,R1,'g')
hold on
plot(pe,R2,'r')
hold off
% fun=@(xk) log2(1-pc.*g+xk)- (xk*log2(exp(1))/(1-pc.*g+xk))- sum(nk*pe*h*g*log2(exp(1))/((1-pc.*g+xk)))
% roots(fun==0) 

function R1=throughput2(pe,pc,nk,pnoise,Tmax,g,h)
cvx_begin
variable t0
variable t(1,10)
%maximize t*(log(cc-pc*g'+t0*nk*pe*(h'.*g')./t')+1.4489*cc)
%maximize t*(log(1-pc*g'+t0*nk*pe*(h'.*g')/20))+1.4489*sum(t)
%maximize t*log(1+t0*nk*pe*(h'.*g')./t'+1.4489*cc)
maximize -sum(rel_entr(t,t.*(1-pc.*g)+t0*nk*pe*(h.*g)))

subject to

t0+sum(t)<=Tmax
t0>=0
t>=0
cvx_end
R1=cvx_optval;
%R=t*(-pc*g')+t0*nk*pe*(h*g')*log2(10);
end
function R2=throughput(pe,pc,nk,pnoise,Tmax,g,h)
cvx_begin
variable t0
variable t1
%maximize t*(log(cc-pc*g'+t0*nk*pe*(h'.*g')./t')+1.4489*cc)
%maximize t*(log(1-pc*g'+t0*nk*pe*(h'.*g')/20))+1.4489*sum(t)
%maximize t*log(1+t0*nk*pe*(h'.*g')./t'+1.4489*cc)
maximize -sum(rel_entr(t1,t1.*sum(1-pc.*g)+sum(t0*nk*pe*(h.*g))))

subject to

t0+t1<=Tmax
t0>=0
t1>=0
cvx_end
R2=cvx_optval;
%R=t*(-pc*g')+t0*nk*pe*(h*g')*log2(10);
end