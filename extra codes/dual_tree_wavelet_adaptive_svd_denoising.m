% 2D dual-tree wavelet transform and adaptive svd image denoising (additive Gaussian noise);
I = imread('90.jpg');
l = size(I);
B_0 = zeros(l(1),l(2));
for i=1:l(1)
    for j=1:l(2)
        B_0(i,j)=I(i,j);
    end
end
sigma = 15;
B_1 = B_0 + sigma*randn(size(B_0));
[Faf, Fsf] = FSfarras;
[af, sf] = dualfilt1;
w = dualtree2D(B_1, 1, Faf, af);
t = dualtree2D(B_0, 1, Faf, af);
noise = dualtree2D(B_1, 1, Faf, af);

CH_1 = w{1}{1}{1};
CV_1 = w{1}{1}{2};
CD_1 = w{1}{1}{3};
CH_2 = w{1}{2}{1};
CV_2 = w{1}{2}{2};
CD_2 = w{1}{2}{3};

p_1 = size(CH_1);
p_2 = size(CV_1);
p_3 = size(CD_1);
p_4 = size(CH_2);
p_5 = size(CV_2);
p_6 = size(CD_2);

CD_1_re = reshape(CD_1,1,p_3(1)*p_3(2));
sigma_1_HH = median(abs(CD_1_re))/0.6745;
CD_2_re = reshape(CD_2,1,p_6(1)*p_6(2));
sigma_2_HH = median(abs(CD_2_re))/0.6745;

if  mod(p_1(1),8)~= 0
    CH(p_1(1)+1:p_1(1)+8-mod(p_1(1),8),:) = 0;
end

if  mod(p_1(2),8)~= 0
    CH(:,p_1(2)+1:p_1(2)+8-mod(p_1(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_2(1),8)~= 0
    CV(p_2(1)+1:p_2(1)+8-mod(p_2(1),8),:) = 0;
end

if  mod(p_2(2),8)~= 0
    CV(:,p_2(2)+1:p_2(2)+8-mod(p_2(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_3(1),8)~= 0
    CD(p_3(1)+1:p_3(1)+8-mod(p_3(1),8),:) = 0;
end

if  mod(p_3(2),8)~= 0
    CD(:,p_3(2)+1:p_3(2)+8-mod(p_3(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_4(1),8)~= 0
    CH(p_4(1)+1:p_4(1)+8-mod(p_4(1),8),:) = 0;
end

if  mod(p_4(2),8)~= 0
    CH(:,p_4(2)+1:p_4(2)+8-mod(p_4(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_5(1),8)~= 0
    CV(p_5(1)+1:p_5(1)+8-mod(p_5(1),8),:) = 0;
end

if  mod(p_5(2),8)~= 0
    CV(:,p_5(2)+1:p_5(2)+8-mod(p_5(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_6(1),8)~= 0
    CD(p_6(1)+1:p_6(1)+8-mod(p_6(1),8),:) = 0;
end

if  mod(p_6(2),8)~= 0
    CD(:,p_6(2)+1:p_6(2)+8-mod(p_6(2),8)) = 0;
end

s_1 = size(CH_1);
s_2 = size(CV_1);
s_3 = size(CD_1);
s_4 = size(CH_2);
s_5 = size(CV_2);
s_6 = size(CD_2);

%making 8*8 Blocks
CH_1_cell = cell((s_1(1)/8),(s_1(2)/8));
for i=0:s_1(1)/8-1
    for j=0:s_1(2)/8-1
        CH_1_cell{i+1,j+1}=CH_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CV_1_cell = cell((s_2(1)/8),(s_2(2)/8));
for i=0:s_2(1)/8-1
    for j=0:s_2(2)/8-1
        CV_1_cell{i+1,j+1}=CV_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CD_1_cell = cell((s_3(1)/8),(s_3(2)/8));
for i=0:s_3(1)/8-1
    for j=0:s_3(2)/8-1
        CD_1_cell{i+1,j+1}=CD_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CH_2_cell = cell((s_4(1)/8),(s_4(2)/8));
for i=0:s_4(1)/8-1
    for j=0:s_4(2)/8-1
        CH_2_cell{i+1,j+1}=CH_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CV_2_cell = cell((s_5(1)/8),(s_5(2)/8));
for i=0:s_5(1)/8-1
    for j=0:s_5(2)/8-1
        CV_2_cell{i+1,j+1}=CV_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CD_2_cell = cell((s_6(1)/8),(s_6(2)/8));
for i=0:s_6(1)/8-1
    for j=0:s_6(2)/8-1
        CD_2_cell{i+1,j+1}=CD_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

ss_1 = cell((s_1(1)/8),(s_1(2)/8));
vv_1 = cell((s_1(1)/8),(s_1(2)/8));
dd_1 = cell((s_1(1)/8),(s_1(2)/8));

ss_2 = cell((s_2(1)/8),(s_2(2)/8));
vv_2 = cell((s_2(1)/8),(s_2(2)/8));
dd_2 = cell((s_2(1)/8),(s_2(2)/8));

ss_3 = cell((s_3(1)/8),(s_3(2)/8));
vv_3 = cell((s_3(1)/8),(s_3(2)/8));
dd_3 = cell((s_3(1)/8),(s_3(2)/8));

ss_4 = cell((s_4(1)/8),(s_4(2)/8));
vv_4 = cell((s_4(1)/8),(s_4(2)/8));
dd_4 = cell((s_4(1)/8),(s_4(2)/8));

ss_5 = cell((s_5(1)/8),(s_5(2)/8));
vv_5 = cell((s_5(1)/8),(s_5(2)/8));
dd_5 = cell((s_5(1)/8),(s_5(2)/8));

ss_6 = cell((s_6(1)/8),(s_6(2)/8));
vv_6 = cell((s_6(1)/8),(s_6(2)/8));
dd_6 = cell((s_6(1)/8),(s_6(2)/8));

for i=1:s_1(1)/8
    for j=1:s_1(2)/8
    [ss_1{i,j} vv_1{i,j} dd_1{i,j}] = svd(CH_1_cell{i,j});
    end
end

for i=1:s_2(1)/8
    for j=1:s_2(2)/8
    [ss_2{i,j} vv_2{i,j} dd_2{i,j}] = svd(CV_1_cell{i,j});
    end
end

for i=1:s_3(1)/8
    for j=1:s_3(2)/8
    [ss_3{i,j} vv_3{i,j} dd_3{i,j}] = svd(CD_1_cell{i,j});
    end
end

for i=1:s_4(1)/8
    for j=1:s_4(2)/8
    [ss_4{i,j} vv_4{i,j} dd_4{i,j}] = svd(CH_2_cell{i,j});
    end
end

for i=1:s_5(1)/8
    for j=1:s_5(2)/8
    [ss_5{i,j} vv_5{i,j} dd_5{i,j}] = svd(CV_2_cell{i,j});
    end
end

for i=1:s_6(1)/8
    for j=1:s_6(2)/8
    [ss_6{i,j} vv_6{i,j} dd_6{i,j}] = svd(CD_2_cell{i,j});
    end
end

%changing svd
vvv_1 = cell((s_1(1)/8),(s_1(2)/8));
sss_1 = cell((s_1(1)/8),(s_1(2)/8));
ddd_1 = cell((s_1(1)/8),(s_1(2)/8));
CH_1_cell_new = cell((s_1(1)/8),(s_1(2)/8));

vvv_2 = cell((s_2(1)/8),(s_2(2)/8));
sss_2 = cell((s_2(1)/8),(s_2(2)/8));
ddd_2 = cell((s_2(1)/8),(s_2(2)/8));
CV_1_cell_new = cell((s_2(1)/8),(s_2(2)/8));

vvv_3 = cell((s_3(1)/8),(s_3(2)/8));
sss_3 = cell((s_3(1)/8),(s_3(2)/8));
ddd_3 = cell((s_3(1)/8),(s_3(2)/8));
CD_1_cell_new = cell((s_3(1)/8),(s_3(2)/8));

vvv_4 = cell((s_4(1)/8),(s_4(2)/8));
sss_4 = cell((s_4(1)/8),(s_4(2)/8));
ddd_4 = cell((s_4(1)/8),(s_4(2)/8));
CH_2_cell_new = cell((s_4(1)/8),(s_4(2)/8));

vvv_5 = cell((s_5(1)/8),(s_5(2)/8));
sss_5 = cell((s_5(1)/8),(s_5(2)/8));
ddd_5 = cell((s_5(1)/8),(s_5(2)/8));
CV_2_cell_new = cell((s_5(1)/8),(s_5(2)/8));

vvv_6 = cell((s_6(1)/8),(s_6(2)/8));
sss_6 = cell((s_6(1)/8),(s_6(2)/8));
ddd_6 = cell((s_6(1)/8),(s_6(2)/8));
CD_2_cell_new = cell((s_6(1)/8),(s_6(2)/8));

% upper channel of tree denoising;
T_1 = zeros(8,8);
T_2 = zeros(8,8);
T_3 = zeros(8,8);
T_4 = zeros(1,8);
K = zeros(8,8);
beta = 5.5;
for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_2 = ss_1{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_3 = transpose(dd_1{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
        for j=1:s_1(2)/8
        CH_1_cell_new{i,j}=sss_1{i,j}*vvv_1{i,j}*ddd_1{i,j};
        end
    end
    CH1 = cell2mat(CH_1_cell_new);
    CH_1_new = CH1(1:p_1(1),1:p_1(2));
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_2 = ss_2{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_3 = transpose(dd_2{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        CV_1_cell_new{i,j}=sss_2{i,j}*vvv_2{i,j}*ddd_2{i,j};
    end
    end
    CV1 = cell2mat(CV_1_cell_new); 
    CV_1_new = CV1(1:p_2(1),1:p_2(2));
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_2 = ss_3{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_3 = transpose(dd_3{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        CD_1_cell_new{i,j}=sss_3{i,j}*vvv_3{i,j}*ddd_3{i,j};
    end
    end
    CD1 = cell2mat(CD_1_cell_new);
    CD_1_new = CD1(1:p_3(1),1:p_3(2));
    
% lower channel of tree denoising;
gamma = 5.5;
for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_2 = ss_4{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_3 = transpose(dd_4{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        CH_2_cell_new{i,j}=sss_4{i,j}*vvv_4{i,j}*ddd_4{i,j};
    end
    end
    CH2 = cell2mat(CH_2_cell_new);
    CH_2_new = CH2(1:p_4(1),1:p_4(2));
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_2 = ss_5{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_3 = transpose(dd_5{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        CV_2_cell_new{i,j}=sss_5{i,j}*vvv_5{i,j}*ddd_5{i,j};
    end
    end
    CV2 = cell2mat(CV_2_cell_new); 
    CV_2_new = CV2(1:p_5(1),1:p_5(2));
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_2 = ss_6{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_3 = transpose(dd_6{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        CD_2_cell_new{i,j}=sss_6{i,j}*vvv_6{i,j}*ddd_6{i,j};
    end
    end
    CD2 = cell2mat(CD_2_cell_new);
    CD_2_new = CD2(1:p_6(1),1:p_6(2));
% create the new array w;
w{1}{1}{1} = CH_1_new;
w{1}{1}{2} = CV_1_new;
w{1}{1}{3} = CD_1_new;
w{1}{2}{1} = CH_2_new;
w{1}{2}{2} = CV_2_new;
w{1}{2}{3} = CD_2_new;
y = idualtree2D(w, 1, Fsf, sf);
original = idualtree2D(t, 1, Fsf, sf);
noisy = idualtree2D(noise, 1, Fsf, sf);
b = mean(mean(B_0));
c = mean(mean(original));
d = b/c;
original = original*d;
y = y*d;
noisy = noisy*d;
MSE_1=0;
    for i=1:l(1)
    for j=1:l(2)
        MSE_1 = MSE_1+((y(i,j)-original(i,j))^2)/(l(1)*l(2));
    end
    end
MSE_2=0;
    for i=1:l(1)
    for j=1:l(2)
        MSE_2 = MSE_2+((noisy(i,j)-original(i,j))^2)/(l(1)*l(2));
    end
    end
    
M = [MSE_1 MSE_2];
subplot(1,3,1);
imagesc(original);
colormap gray;
title('original image');
subplot(1,3,2);
imagesc(noisy);
colormap gray;
title('noisy image');
subplot(1,3,3);
imagesc(y);
colormap gray;
title('denoised image');
snr_1 = calSNR(original,y);
snr_2 = calSNR(original,noisy);
snr = [snr_1 snr_2];
%%
% dual tree wavelet and adaptive svd image denoising (despeckling);
I = imread('90.jpg');
l = size(I);
B_0 = zeros(l(1),l(2));
for i=1:l(1)
    for j=1:l(2)
        B_0(i,j)=I(i,j);
    end
end
B_1 = speck(B_0,0.5,3,3);
B_1 = log(B_1);
B_0(B_0==0) = 1;
B_0 = log(B_0);
[Faf, Fsf] = FSfarras;
[af, sf] = dualfilt1;
w = dualtree2D(B_1, 1, Faf, af);
t = dualtree2D(B_0, 1, Faf, af);
noise = dualtree2D(B_1, 1, Faf, af);

CH_1 = w{1}{1}{1};
CV_1 = w{1}{1}{2};
CD_1 = w{1}{1}{3};
CH_2 = w{1}{2}{1};
CV_2 = w{1}{2}{2};
CD_2 = w{1}{2}{3};

p_1 = size(CH_1);
p_2 = size(CV_1);
p_3 = size(CD_1);
p_4 = size(CH_2);
p_5 = size(CV_2);
p_6 = size(CD_2);

CD_1_re = reshape(CD_1,1,p_3(1)*p_3(2));
sigma_1_HH = median(abs(CD_1_re))/0.6745;
CD_2_re = reshape(CD_2,1,p_6(1)*p_6(2));
sigma_2_HH = median(abs(CD_2_re))/0.6745;

if  mod(p_1(1),8)~= 0
    CH(p_1(1)+1:p_1(1)+8-mod(p_1(1),8),:) = 0;
end

if  mod(p_1(2),8)~= 0
    CH(:,p_1(2)+1:p_1(2)+8-mod(p_1(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_2(1),8)~= 0
    CV(p_2(1)+1:p_2(1)+8-mod(p_2(1),8),:) = 0;
end

if  mod(p_2(2),8)~= 0
    CV(:,p_2(2)+1:p_2(2)+8-mod(p_2(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_3(1),8)~= 0
    CD(p_3(1)+1:p_3(1)+8-mod(p_3(1),8),:) = 0;
end

if  mod(p_3(2),8)~= 0
    CD(:,p_3(2)+1:p_3(2)+8-mod(p_3(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_4(1),8)~= 0
    CH(p_4(1)+1:p_4(1)+8-mod(p_4(1),8),:) = 0;
end

if  mod(p_4(2),8)~= 0
    CH(:,p_4(2)+1:p_4(2)+8-mod(p_4(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_5(1),8)~= 0
    CV(p_5(1)+1:p_5(1)+8-mod(p_5(1),8),:) = 0;
end

if  mod(p_5(2),8)~= 0
    CV(:,p_5(2)+1:p_5(2)+8-mod(p_5(2),8)) = 0;
end
%%%%%%%%%%
if  mod(p_6(1),8)~= 0
    CD(p_6(1)+1:p_6(1)+8-mod(p_6(1),8),:) = 0;
end

if  mod(p_6(2),8)~= 0
    CD(:,p_6(2)+1:p_6(2)+8-mod(p_6(2),8)) = 0;
end

s_1 = size(CH_1);
s_2 = size(CV_1);
s_3 = size(CD_1);
s_4 = size(CH_2);
s_5 = size(CV_2);
s_6 = size(CD_2);

%making 8*8 Blocks
CH_1_cell = cell((s_1(1)/8),(s_1(2)/8));
for i=0:s_1(1)/8-1
    for j=0:s_1(2)/8-1
        CH_1_cell{i+1,j+1}=CH_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CV_1_cell = cell((s_2(1)/8),(s_2(2)/8));
for i=0:s_2(1)/8-1
    for j=0:s_2(2)/8-1
        CV_1_cell{i+1,j+1}=CV_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CD_1_cell = cell((s_3(1)/8),(s_3(2)/8));
for i=0:s_3(1)/8-1
    for j=0:s_3(2)/8-1
        CD_1_cell{i+1,j+1}=CD_1(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CH_2_cell = cell((s_4(1)/8),(s_4(2)/8));
for i=0:s_4(1)/8-1
    for j=0:s_4(2)/8-1
        CH_2_cell{i+1,j+1}=CH_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CV_2_cell = cell((s_5(1)/8),(s_5(2)/8));
for i=0:s_5(1)/8-1
    for j=0:s_5(2)/8-1
        CV_2_cell{i+1,j+1}=CV_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

CD_2_cell = cell((s_6(1)/8),(s_6(2)/8));
for i=0:s_6(1)/8-1
    for j=0:s_6(2)/8-1
        CD_2_cell{i+1,j+1}=CD_2(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end

ss_1 = cell((s_1(1)/8),(s_1(2)/8));
vv_1 = cell((s_1(1)/8),(s_1(2)/8));
dd_1 = cell((s_1(1)/8),(s_1(2)/8));

ss_2 = cell((s_2(1)/8),(s_2(2)/8));
vv_2 = cell((s_2(1)/8),(s_2(2)/8));
dd_2 = cell((s_2(1)/8),(s_2(2)/8));

ss_3 = cell((s_3(1)/8),(s_3(2)/8));
vv_3 = cell((s_3(1)/8),(s_3(2)/8));
dd_3 = cell((s_3(1)/8),(s_3(2)/8));

ss_4 = cell((s_4(1)/8),(s_4(2)/8));
vv_4 = cell((s_4(1)/8),(s_4(2)/8));
dd_4 = cell((s_4(1)/8),(s_4(2)/8));

ss_5 = cell((s_5(1)/8),(s_5(2)/8));
vv_5 = cell((s_5(1)/8),(s_5(2)/8));
dd_5 = cell((s_5(1)/8),(s_5(2)/8));

ss_6 = cell((s_6(1)/8),(s_6(2)/8));
vv_6 = cell((s_6(1)/8),(s_6(2)/8));
dd_6 = cell((s_6(1)/8),(s_6(2)/8));

for i=1:s_1(1)/8
    for j=1:s_1(2)/8
    [ss_1{i,j} vv_1{i,j} dd_1{i,j}] = svd(CH_1_cell{i,j});
    end
end

for i=1:s_2(1)/8
    for j=1:s_2(2)/8
    [ss_2{i,j} vv_2{i,j} dd_2{i,j}] = svd(CV_1_cell{i,j});
    end
end

for i=1:s_3(1)/8
    for j=1:s_3(2)/8
    [ss_3{i,j} vv_3{i,j} dd_3{i,j}] = svd(CD_1_cell{i,j});
    end
end

for i=1:s_4(1)/8
    for j=1:s_4(2)/8
    [ss_4{i,j} vv_4{i,j} dd_4{i,j}] = svd(CH_2_cell{i,j});
    end
end

for i=1:s_5(1)/8
    for j=1:s_5(2)/8
    [ss_5{i,j} vv_5{i,j} dd_5{i,j}] = svd(CV_2_cell{i,j});
    end
end

for i=1:s_6(1)/8
    for j=1:s_6(2)/8
    [ss_6{i,j} vv_6{i,j} dd_6{i,j}] = svd(CD_2_cell{i,j});
    end
end

%changing svd
vvv_1 = cell((s_1(1)/8),(s_1(2)/8));
sss_1 = cell((s_1(1)/8),(s_1(2)/8));
ddd_1 = cell((s_1(1)/8),(s_1(2)/8));
CH_1_cell_new = cell((s_1(1)/8),(s_1(2)/8));

vvv_2 = cell((s_2(1)/8),(s_2(2)/8));
sss_2 = cell((s_2(1)/8),(s_2(2)/8));
ddd_2 = cell((s_2(1)/8),(s_2(2)/8));
CV_1_cell_new = cell((s_2(1)/8),(s_2(2)/8));

vvv_3 = cell((s_3(1)/8),(s_3(2)/8));
sss_3 = cell((s_3(1)/8),(s_3(2)/8));
ddd_3 = cell((s_3(1)/8),(s_3(2)/8));
CD_1_cell_new = cell((s_3(1)/8),(s_3(2)/8));

vvv_4 = cell((s_4(1)/8),(s_4(2)/8));
sss_4 = cell((s_4(1)/8),(s_4(2)/8));
ddd_4 = cell((s_4(1)/8),(s_4(2)/8));
CH_2_cell_new = cell((s_4(1)/8),(s_4(2)/8));

vvv_5 = cell((s_5(1)/8),(s_5(2)/8));
sss_5 = cell((s_5(1)/8),(s_5(2)/8));
ddd_5 = cell((s_5(1)/8),(s_5(2)/8));
CV_2_cell_new = cell((s_5(1)/8),(s_5(2)/8));

vvv_6 = cell((s_6(1)/8),(s_6(2)/8));
sss_6 = cell((s_6(1)/8),(s_6(2)/8));
ddd_6 = cell((s_6(1)/8),(s_6(2)/8));
CD_2_cell_new = cell((s_6(1)/8),(s_6(2)/8));

% upper channel of tree denoising;
T_1 = zeros(8,8);
T_2 = zeros(8,8);
T_3 = zeros(8,8);
T_4 = zeros(1,8);
K = zeros(8,8);
% beta = input('insert the value of beta = ');
beta = 3:0.01:12;
z = length(beta);
A_1 = cell(1,z);
A_2 = cell(1,z);
A_3 = cell(1,z);
lambda = 1;
for beta=3:0.01:12
for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_2 = ss_1{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
    for j=1:s_1(2)/8
        T_1 = vv_1{i,j};
        T_3 = transpose(dd_1{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_1{i,j}= K;
    end
    end
    for i=1:s_1(1)/8
        for j=1:s_1(2)/8
        CH_1_cell_new{i,j}=sss_1{i,j}*vvv_1{i,j}*ddd_1{i,j};
        end
    end
    CH1 = cell2mat(CH_1_cell_new);
    CH_1_new = CH1(1:p_1(1),1:p_1(2));
    A_1{lambda} = CH_1_new;
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_2 = ss_2{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        T_1 = vv_2{i,j};
        T_3 = transpose(dd_2{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_2{i,j}= K;
    end
    end
    for i=1:s_2(1)/8
    for j=1:s_2(2)/8
        CV_1_cell_new{i,j}=sss_2{i,j}*vvv_2{i,j}*ddd_2{i,j};
    end
    end
    CV1 = cell2mat(CV_1_cell_new); 
    CV_1_new = CV1(1:p_2(1),1:p_2(2));
    A_2{lambda} = CV_1_new;
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_2 = ss_3{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        T_1 = vv_3{i,j};
        T_3 = transpose(dd_3{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>sigma_1_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_1_HH
            for a=8:-1:1
                if T_4(a)>beta*sigma_1_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_3{i,j}= K;
    end
    end
    for i=1:s_3(1)/8
    for j=1:s_3(2)/8
        CD_1_cell_new{i,j}=sss_3{i,j}*vvv_3{i,j}*ddd_3{i,j};
    end
    end
    CD1 = cell2mat(CD_1_cell_new);
    CD_1_new = CD1(1:p_3(1),1:p_3(2));
    A_3{lambda} = CD_1_new;
    lambda = lambda + 1;
end

% lower channel of tree denoising;
% gamma = input('insert the value of gamma = ');
gamma = 3:0.01:12;
A_4 = cell(1,z);
A_5 = cell(1,z);
A_6 = cell(1,z);
zeta = 1;
for gamma=3:0.01:12
for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_2 = ss_4{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        T_1 = vv_4{i,j};
        T_3 = transpose(dd_4{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_4{i,j}= K;
    end
    end
    for i=1:s_4(1)/8
    for j=1:s_4(2)/8
        CH_2_cell_new{i,j}=sss_4{i,j}*vvv_4{i,j}*ddd_4{i,j};
    end
    end
    CH2 = cell2mat(CH_2_cell_new);
    CH_2_new = CH2(1:p_4(1),1:p_4(2));
    A_4{zeta} = CH_2_new;
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_2 = ss_5{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        T_1 = vv_5{i,j};
        T_3 = transpose(dd_5{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_5{i,j}= K;
    end
    end
    for i=1:s_5(1)/8
    for j=1:s_5(2)/8
        CV_2_cell_new{i,j}=sss_5{i,j}*vvv_5{i,j}*ddd_5{i,j};
    end
    end
    CV2 = cell2mat(CV_2_cell_new); 
    CV_2_new = CV2(1:p_5(1),1:p_5(2));
    A_5{zeta} = CV_2_new;
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_1(1:e,1:e);
                    break
                elseif a==1
                    K = T_1(1:a,1:a);
                end
            end
        end
        vvv_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_2 = ss_6{i,j}; 
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_2(1:8,1:e);
                    break
                elseif a==1
                    K = T_2(1:8,1:a);
                end
            end
        end
        sss_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        T_1 = vv_6{i,j};
        T_3 = transpose(dd_6{i,j});
        T_4 = diag(T_1);
        if median(T_4)>gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>sigma_2_HH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=gamma*sigma_2_HH
            for a=8:-1:1
                if T_4(a)>gamma*sigma_2_HH
                    e = a;
                    K = T_3(1:e,1:8);
                    break
                elseif a==1
                    K = T_3(1:a,1:8);
                end
            end
        end
        ddd_6{i,j}= K;
    end
    end
    for i=1:s_6(1)/8
    for j=1:s_6(2)/8
        CD_2_cell_new{i,j}=sss_6{i,j}*vvv_6{i,j}*ddd_6{i,j};
    end
    end
    CD2 = cell2mat(CD_2_cell_new);
    CD_2_new = CD2(1:p_6(1),1:p_6(2));
    A_6{zeta} = CD_2_new;
    zeta = zeta + 1;
end
% create the new array w;
original = idualtree2D(t, 1, Fsf, sf);
noisy = idualtree2D(noise, 1, Fsf, sf);
b = mean(mean(B_0));
c = mean(mean(original));
d = b/c;
original = original*d;
noisy = noisy*d;
original = exp(original);
noisy = exp(noisy);
for i=1:z
    w{1}{1}{1} = A_1{i};
    w{1}{1}{2} = A_2{i};
    w{1}{1}{3} = A_3{i};
    w{1}{2}{1} = A_4{i};
    w{1}{2}{2} = A_5{i};
    w{1}{2}{3} = A_6{i};
    y{i} = idualtree2D(w, 1, Fsf, sf);
    y{i} = y{i}*d;
    y{i} = exp(y{i});
end
M = zeros(1,z);
for u=1:z
    MSE=0;
    for i=1:l(1)
        for j=1:l(2)
        MSE = MSE+((y{u}(i,j)-original(i,j))^2)/(l(1)*l(2));
        end
    end
    M(u) = MSE;
end
beta = 3:0.01:12;
figure;
plot(beta,M,'*');
xlabel('beta or gamma');
ylabel('MSE');
title('comparison between the denoised image and original image');
% subplot(1,3,1);
% imagesc(original);
% colormap gray;
% title('original image');
% subplot(1,3,2);
% imagesc(noisy);
% colormap gray;
% title('noisy image');
% subplot(1,3,3);
% imagesc(y);
% colormap gray;
% title('denoised image');


