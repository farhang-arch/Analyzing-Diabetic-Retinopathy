%% Wavelet Sparsity Measurement
% I_1 = imread('camera.jpg');
% I_2 = rgb2gray(I_1);
% l = size(I_2);
% A = zeros(l);
% for i=1:l(1)
%     for j=1:l(2)
%         A(i,j) = I_2(i,j);
%     end
% end
load('X1');
l = size(X);
% if mod(l(1),2)~= 0
%     X(l(1),:) = [];
% end
% if mod(l(2),2)~= 0
%     X(:,l(2)) = [];
% end
wname = input('insert type of filter = ');
level = input('insert the number of levels = ');
[W,V] = wavedec2(X,level,wname);  
% sparsity of wavelet domain;
wavelet_sparsity = gini(W);
%% Curvelet Sparsity Measurement
nbscales_default = ceil(log2(min(l(1),l(2)))-3);
is_real = input('insert the value of is_real = ');% please insert 0 or 1;
finest = input('insert the value of finest = ');% please insert 1 or 2;
nbscales = input('insert the value of nbscales = ');% number of scales, default value: ceil(log2(min(M,N)) - 3)];
nbangles_coarse = input('insert the value of nbangles_coarse = ');% number of angles at the 2nd coarsest level, minimum 8,
% must be a multiple of 4. [default set to 16];
C = fdct_wrapping(X, is_real, finest, nbscales, nbangles_coarse);
curve_1 = C{1}{1};
q = size(curve_1);
u = reshape(curve_1,1,q(1)*q(2));
%
y = [];
for i=1:16
    curve = C{2}{i};
    p = size(curve);
    curve_re = reshape(curve,1,p(1)*p(2));
    t = curve_re;
    y = [y t];
end
CC = [u y];
% sparsity of curvelet domain;
curvelet_sparsity = gini(CC);

