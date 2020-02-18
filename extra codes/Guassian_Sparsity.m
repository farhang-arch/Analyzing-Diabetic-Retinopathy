
%%-------------Guassian Sparsity Measurment -----------------------------
%-------------------Input Data-Vectors---------------------------------
a=ones(1,1000);
b=2*ones(1,1000);
c=[zeros(1,999),1];
d=[ones(1,999),2];
f=[2*ones(1,500),ones(1,500)];
g=[zeros(1,999),15];
h=rand(1,1000);
k=[zeros(1,9999),1];
l=rand(1,10000);

%-------------- Guassian Parameter ------------------------------------

% obja = gmdistribution.fit(a',1);
% objb = gmdistribution.fit(b',1);
objc = gmdistribution.fit(c',1);
objd = gmdistribution.fit(d',1);
% obje = gmdistribution.fit(e',1);
objf = gmdistribution.fit(f',1);
objg = gmdistribution.fit(g',1);
objh = gmdistribution.fit(h',1);
objk = gmdistribution.fit(k',1);
objl = gmdistribution.fit(l',1);

%---------------GSM & Gini index---------------------------------------

% sa=(obja.Sigma)/(obja.mu).^2;ya=gini(a);
% sb=(objb.Sigma)/(objb.mu).^2;yb=gini(b);
sc=(objc.Sigma)/(objc.mu).^2;yc=gini(c);
sd=(objd.Sigma)/(objd.mu).^2;yd=gini(d);
% se=(obje.Sigma)/(obje.mu).^2;ye=gini(e);
sf=(objf.Sigma)/(objf.mu).^2;yf=gini(f);
sg=(objg.Sigma)/(objg.mu).^2;yg=gini(g);
sh=(objh.Sigma)/(objh.mu).^2;yh=gini(h);
sk=(objk.Sigma)/(objk.mu).^2;yk=gini(k);
sl=(objl.Sigma)/(objl.mu).^2;yl=gini(l);

%-------------Plot Guassian Dist. ------------------------------------
x=[-3:0.001:3];

% figure;
% plot(x,normpdf(x,obja.mu,obja.Sigma));
% title('a')
% 
% figure;
% plot(x,normpdf(x,objb.mu,objb.Sigma));
% title('b')

figure;
plot(x,normpdf(x,objc.mu,objc.Sigma));
title('c')

figure;
plot(x,normpdf(x,objd.mu,objd.Sigma));
title('d')

% figure;
% plot(x,normpdf(x,obje.mu,obje.Sigma));
% title('e')

figure;
plot(x,normpdf(x,objf.mu,objf.Sigma));
title('f')

figure;
plot(x,normpdf(x,objg.mu,objg.Sigma));
title('g')

figure;
plot(x,normpdf(x,objh.mu,objh.Sigma));
title('h')

figure;
plot(x,normpdf(x,objk.mu,objk.Sigma));
title('k')

figure;
plot(x,normpdf(x,objl.mu,objl.Sigma));
title('l')

%----------------------End--------------------------------------------