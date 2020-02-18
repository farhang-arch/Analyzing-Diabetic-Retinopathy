function [ imgout ] = proposed_denoising( input_img, wname )
%   UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% l=size(input_img);
[CA, CH, CV, CD]=dwt2(input_img,wname);
p=size(CH);
sigma_CV=median(abs(CV(:)))/0.6745;
sigma_CH=median(abs(CH(:)))/0.6745;
sigma_CD=median(abs(CD(:)))/0.6745;
% zero insert
if  mod(p(1),8)~= 0
    CH(p(1)+1:p(1)+8-mod(p(1),8),:) = 0;
    CV(p(1)+1:p(1)+8-mod(p(1),8),:) = 0;
    CD(p(1)+1:p(1)+8-mod(p(1),8),:) = 0;
end

if  mod(p(2),8)~= 0
    CH(:,p(2)+1:p(2)+8-mod(p(2),8)) = 0;
    CV(:,p(2)+1:p(2)+8-mod(p(2),8)) = 0;
    CD(:,p(2)+1:p(2)+8-mod(p(2),8)) = 0;
end
s=size(CH);
% making 8x8 blocks
% CH_cell
CH_cell = cell((s(1)/8),(s(2)/8));
for i=0:s(1)/8-1
    for j=0:s(2)/8-1
        CH_cell{i+1,j+1}=CH(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end
% CV_cell
CV_cell = cell((s(1)/8),(s(2)/8));
for i=0:s(1)/8-1
    for j=0:s(2)/8-1
        CV_cell{i+1,j+1}=CV(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end
% CD_cell
CD_cell = cell((s(1)/8),(s(2)/8));
for i=0:s(1)/8-1
    for j=0:s(2)/8-1
        CD_cell{i+1,j+1}=CD(8*i+1:8*(i+1),8*j+1:8*(j+1));
    end
end
% SVD_cell_computation
ss_2 = cell((s(1)/8),(s(2)/8));
vv_2 = cell((s(1)/8),(s(2)/8));
dd_2 = cell((s(1)/8),(s(2)/8));

ss_3 = cell((s(1)/8),(s(2)/8));
vv_3 = cell((s(1)/8),(s(2)/8));
dd_3 = cell((s(1)/8),(s(2)/8));

ss_4 = cell((s(1)/8),(s(2)/8));
vv_4 = cell((s(1)/8),(s(2)/8));
dd_4 = cell((s(1)/8),(s(2)/8));

for i=1:s(1)/8
    for j=1:s(2)/8
    [ss_2{i,j}, vv_2{i,j}, dd_2{i,j}] = svd(CH_cell{i,j});
    end
end

for i=1:s(1)/8
    for j=1:s(2)/8
    [ss_3{i,j}, vv_3{i,j}, dd_3{i,j}] = svd(CV_cell{i,j});
    end
end

for i=1:s(1)/8
    for j=1:s(2)/8
    [ss_4{i,j}, vv_4{i,j}, dd_4{i,j}] = svd(CD_cell{i,j});
    end
end
% changing SVD
vvv_2 = cell((s(1)/8),(s(2)/8));
sss_2 = cell((s(1)/8),(s(2)/8));
ddd_2 = cell((s(1)/8),(s(2)/8));
CH_cell_new = cell((s(1)/8),(s(2)/8));

vvv_3 = cell((s(1)/8),(s(2)/8));
sss_3 = cell((s(1)/8),(s(2)/8));
ddd_3 = cell((s(1)/8),(s(2)/8));
CV_cell_new = cell((s(1)/8),(s(2)/8));

vvv_4 = cell((s(1)/8),(s(2)/8));
sss_4 = cell((s(1)/8),(s(2)/8));
ddd_4 = cell((s(1)/8),(s(2)/8));
CD_cell_new = cell((s(1)/8),(s(2)/8));

% T_1 = zeros(8,8);
% T_2 = zeros(8,8);
% T_3 = zeros(8,8);
% T_4 = zeros(1,8);
K = zeros(8,8);
beta=6;
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_2{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CH
            for a=8:-1:1
                if T_4(a)>sigma_CH
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_CH
            for a=8:-1:1
                if T_4(a)>beta*sigma_CH
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_2{i,j};
        T_2 = ss_2{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CH
            for a=8:-1:1
                if T_4(a)>sigma_CH
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_CH
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CH
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_2{i,j};
        T_3 = transpose(dd_2{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CH
            for a=8:-1:1
                if T_4(a)>sigma_CH
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_CH
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CH
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
for i=1:s(1)/8
    for j=1:s(2)/8
        CH_cell_new{i,j}=sss_2{i,j}*vvv_2{i,j}*ddd_2{i,j};
    end
end
CH1 = cell2mat(CH_cell_new);
CH_new = CH1(1:p(1),1:p(2));
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_3{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CV
            for a=8:-1:1
                if T_4(a)>sigma_CV
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_CV
            for a=8:-1:1
                if T_4(a)>beta*sigma_CV
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_3{i,j};
        T_2 = ss_3{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CV
            for a=8:-1:1
                if T_4(a)>sigma_CV
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_CV
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CV
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_3{i,j};
        T_3 = transpose(dd_3{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CV
            for a=8:-1:1
                if T_4(a)>sigma_CV
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_CV
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CV
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
for i=1:s(1)/8
    for j=1:s(2)/8
        CV_cell_new{i,j}=sss_3{i,j}*vvv_3{i,j}*ddd_3{i,j};
    end
end
CV1 = cell2mat(CV_cell_new);
CV_new = CV1(1:p(1),1:p(2));
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_4{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CD
            for a=8:-1:1
                if T_4(a)>sigma_CD
                    e = a;
                    break
                end
            end
            K = T_1(1:e,1:e);
        elseif median(T_4)<=beta*sigma_CD
            for a=8:-1:1
                if T_4(a)>beta*sigma_CD
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_4{i,j};
        T_2 = ss_4{i,j};
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CD
            for a=8:-1:1
                if T_4(a)>sigma_CD
                    e = a;
                    break
                end
            end
            K = T_2(1:8,1:e);
            elseif median(T_4)<=beta*sigma_CD
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CD
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
for i=1:s(1)/8
    for j=1:s(2)/8
        T_1 = vv_4{i,j};
        T_3 = transpose(dd_4{i,j});
        T_4 = diag(T_1);
        if median(T_4)>beta*sigma_CD
            for a=8:-1:1
                if T_4(a)>sigma_CD
                    e = a;
                    break
                end
            end
            K = T_3(1:e,1:8);
            elseif median(T_4)<=beta*sigma_CD
                for a=8:-1:1
                    if T_4(a)>beta*sigma_CD
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
for i=1:s(1)/8
    for j=1:s(2)/8
        CD_cell_new{i,j}=sss_4{i,j}*vvv_4{i,j}*ddd_4{i,j};
    end
end
CD1 = cell2mat(CD_cell_new);
CD_new = CD1(1:p(1),1:p(2));
imgout=idwt2(CA,CH_new,CV_new,CD_new,wname);

end

