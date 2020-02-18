% Figures - 14.10 and 14.11
% =========================================
% This function applies the K-SVD denoising algorithm. The dictionary
% is trained using patches from the corrupted image. Note that the 
% implimentation here is very slow, and a much better one could 
% be obtained using the K-SVD package by Ron Rubinstein. See 
% http://www.cs.technion.ac.il/~elad/software for more details.


function []=project_code()
clear;
clc;
close all;
% global patch_nt patch_ns;
inimage=imread('C:\Users\Lenovo\Desktop\seismic3.bmp');

grimage=rgb2gray(inimage);
% N_of_rows=209;
% N_of_columns=170;
noo=40;
N_of_rows=232;
N_of_columns=232;
resized_image=imresize(grimage,[N_of_rows N_of_columns]);
% resized_image=uint8(resized_image./2);
main_image=double(0.93*resized_image);
str = ('main image');
figure('Name',str,'NumberTitle','off');
imshow(main_image);
% figure;
% imshow(resized_image);

rcounter=0;
f=zeros(N_of_columns*N_of_rows,1);
for j=1:N_of_columns
    for i=1:N_of_rows
        rcounter=rcounter+1;
        f(rcounter)=resized_image(i,j);
    end
end
fc=f;
oblique_start=zeros(N_of_columns,2);        %%%start of origin of every oblique for every trace
x=zeros(1,N_of_columns);                    %%%random number added to oblique origin row number
x(1)=0;
for i=2:N_of_columns
    x(i)=floor(3*randn);
    while (abs(x(i)-x(i-1))<=1)
        x(i)=floor(3*randn);
    end  
end
oblique_start(1,1)=1;
oblique_start(1,2)=1;
% shift=N_of_rows/2;
shift=150;
for i=2:N_of_columns
    oblique_start(i,1)=oblique_start(i-1,1)+N_of_rows-shift+x(i);
    oblique_start(i,2)=oblique_start(i-1,2)+N_of_rows;
end
                    %%%%loading the blending matrix-->gamma 
gamma=zeros(oblique_start(N_of_columns,1)+N_of_rows-1,N_of_rows*N_of_columns);
for i=1:N_of_columns
    for j=1:N_of_rows
        gamma(oblique_start(i,1)+j-1,oblique_start(i,2)+j-1)=1;
    end
end  

b=gamma*f;
                   %showing the blended image
final_image=zeros(N_of_rows-shift-1,N_of_columns);
for j=1:N_of_columns
    final_image(:,j)=b(oblique_start(j,1):oblique_start(j,1)+N_of_rows-shift-1-1);
end 

str = ('blended image');
figure('Name',str,'NumberTitle','off');
imshow((final_image));


%{
final_images=medfilt2(final_image);
figure;
imshow(final_images);
%}

 

% initialization
f=gamma'*b;    %f is initialized as the pseudodeblending gamma transpose multipled by b(measurement)
                %showing f as initial image,resized_image is used to show
                %it to save the ram memory


for j=1:N_of_columns
    resized_image(:,j)=f((j-1)*N_of_rows+1:j*N_of_rows);
end

% rcounter=0;
% for j=1:N_of_columns
%     for i=1:N_of_rows
%         rcounter=rcounter+1;
%         f(rcounter)=resized_image(i,j);
%     end
% end

str = ('initial recovery image');
figure('Name',str,'NumberTitle','off');
imshow(resized_image);
noisy_image = double(imnoise(resized_image,'gaussian',0,0.02));

intermediate_images=uint8(zeros(N_of_rows,N_of_columns,25));
for i=1:25
    med_image=(noisy_image+((main_image-noisy_image)/25)*i);
%     str =['int image ',num2str(i)]; 
% figure('Name',str,'NumberTitle','off');
intermediate_images(:,:,i)=uint8(med_image);
% imshow((intermediate_images(:,:,i)));
end
    
str = ('initial noisy image');
figure('Name',str,'NumberTitle','off');
imshow(noisy_image);

K=256; 
n=8; 
sigma=20; % noise power
const=sqrt(1.15); 
numIteration=20; 
lambda=0.5; 

% Gather the data from the noisy Barbara

% y0=imread('barbara.png');
y0=intermediate_images(:,:,1);
y0=double(y0); % (401:500,401:500));

N=size(y0,1);
noise=randn(N,N);
y=y0+sigma*noise; % add noise
figcounter=0;
% while(1)
%     figcounter=figcounter+1;
PSNRinput=10*log10(255^2/mean((y(:)-y0(:)).^2)); 

Data=zeros(n^2,(N-n+1)^2);
cnt=1; 
for j=1:1:N-n+1
    for i=1:1:N-n+1
        patch=y(i:i+n-1,j:j+n-1);
        Data(:,cnt)=patch(:); 
        cnt=cnt+1;
    end;
end;

% if (figcounter==1)
% initialize the dictionary
Dictionary=zeros(n,sqrt(K));
for k=0:1:sqrt(K)-1,
    V=cos([0:1:n-1]*k*pi/sqrt(K));
    if k>0, V=V-mean(V); end;
    Dictionary(:,k+1)=V/norm(V);
end;
Dictionary=kron(Dictionary,Dictionary);
Dictionary=Dictionary*diag(1./sqrt(sum(Dictionary.*Dictionary)));
IMdict=Chapter_12_DispDict(Dictionary,sqrt(K),sqrt(K),n,n,0);
figure(1); clf; 
imagesc(IMdict); colormap(gray(256)); axis image; axis off; drawnow;
% end
% print -depsc2 Chapter_14_KSVD_dic0.eps

% zeroing various result vectors
TotalErr=zeros(1,21+1);
NumCoef=zeros(1,21+1);

% Sparse coding with the initial dictionary
CoefMatrix=OMPerr(Dictionary,Data, sigma*const);
yout=RecoverImage(y,lambda,Dictionary,CoefMatrix); 
PSNRoutput=10*log10(255^2/mean((yout(:)-y0(:)).^2)); 
disp([PSNRinput,PSNRoutput]);
figure(2); clf; 
imagesc(yout); colormap(gray(256)); axis image; axis off; drawnow;
% print -depsc2 Chapter_14_KSVD_im0.eps

% compute the errors
counter=1;
TotalErr(counter)=sqrt(sum(sum((Data-Dictionary*CoefMatrix).^2))/numel(Data));
NumCoef(counter)=length(find(CoefMatrix))/size(Data,2);
disp(['Iteration ',num2str(0),':  Error=',num2str(TotalErr(counter)), ...
    ', Average cardinality: ',num2str(NumCoef(counter))]);
counter=counter+1;

% Main Iterations
for iterNum=1:numIteration

    % Update the dictionary
    Dictionary(:,1)=Dictionary(:,1); % the DC term remain unchanged
    for j=2:1:size(Dictionary,2)
        relevantDataIndices=find(CoefMatrix(j,:));
        if ~isempty(relevantDataIndices)
            tmpCoefMatrix=CoefMatrix(:,relevantDataIndices);
            tmpCoefMatrix(j,:)=0;
            errors=Data(:,relevantDataIndices)-Dictionary*tmpCoefMatrix;
            [betterDictionaryElement,singularValue,betaVector]=svds(errors,1);
            CoefMatrix(j,relevantDataIndices)=singularValue*betaVector';
            Dictionary(:,j)=betterDictionaryElement;
        end;
    end;
    IMdict=CDispDict(Dictionary,sqrt(K),sqrt(K),n,n,0);
    figure(3); clf; 
    imagesc(IMdict); colormap(gray(256)); axis image; axis off; drawnow; 
    % print -depsc2 Chapter_14_KSVD_dicTrain.eps

    % Compute the errors and display
    TotalErr(counter)=sqrt(sum(sum((Data-Dictionary*CoefMatrix).^2))/numel(Data));
    NumCoef(counter)=length(find(CoefMatrix))/size(Data,2);
    disp(['Iteration ',num2str(iterNum),': Error=',num2str(TotalErr(counter)),...
        ', Average cardinality: ',num2str(NumCoef(counter))]);
    counter=counter+1;
    
    % remove rarely used or too-close atoms
    T2=0.99; T1=3;
    Er=sum((Data-Dictionary*CoefMatrix).^2,1);
    G=Dictionary'*Dictionary;
    G=G-diag(diag(G));
    for j=2:1:size(Dictionary,2)
        if max(G(j,:))>T2
            alternativeAtom=find(G(j,:)==max(G(j,:)));
            [val,pos]=max(Er);
            Er(pos(1))=0;
            Dictionary(:,j)=Data(:,pos(1))/norm(Data(:,pos(1)));
            G=Dictionary'*Dictionary;
            G=G-diag(diag(G));            
        elseif length(find(abs(CoefMatrix(j,:))>1e-7))<=T1
            [val,pos]=max(Er);
            Er(pos(1))=0;
            Dictionary(:,j)=Data(:,pos(1))/norm(Data(:,pos(1)));
            G=Dictionary'*Dictionary;
            G=G-diag(diag(G));
        end;
    end;
    
    % Sparse coding: find the coefficients
    CoefMatrix=OMPerr(Dictionary,Data,sigma*const);
    yout=RecoverImage(y,lambda,Dictionary,CoefMatrix); 
    PSNRoutput=10*log10(255^2/mean((yout(:)-y0(:)).^2)); 
    disp([PSNRinput,PSNRoutput]);
    figure(4); clf; 
    imagesc(yout); colormap(gray(256)); axis image; axis off; drawnow;
    % print -depsc2 Chapter_14_KSVD_imTrain.eps

    % Compute the errors and display
    TotalErr(counter)=sqrt(sum(sum((Data-Dictionary*CoefMatrix).^2))/numel(Data));
    NumCoef(counter)=length(find(CoefMatrix))/size(Data,2);
    disp(['Iteration ',num2str(iterNum),': Error=',num2str(TotalErr(counter)),...
        ', Average cardinality: ',num2str(NumCoef(counter))]);
    counter=counter+1;
    




end;


%     str = ['denoised pic:',num2str(figcounter)];
%     figure('Name',str,'NumberTitle','off');
%     imshow((yout));
rcounter=0;
% fdn=zeros(N_of_columns*N_of_rows,1);
% for j=1:N_of_columns
%     for i=1:N_of_rows
%         rcounter=rcounter+1;
%        fdn(rcounter)=yout(i,j);
%     end
% end
% for s=1:10
%     figcounter=figcounter+1;
% cvx_begin
%    variable X(N_of_columns*N_of_rows,1);
%         minimize(noo*sum_square((gamma*X)-b)+sum_square(X-fdn));
% cvx_end
% resultf=X;
% fdn=X;
% for j=1:N_of_columns
%     y(:,j)=resultf((j-1)*N_of_rows+1:j*N_of_rows);
% end
%    str = ['optimized pic:',num2str(figcounter)];
%     figure('Name',str,'NumberTitle','off');
%     imshow(uint8(y));
%      residualimage=uint8(abs(y-mainimage));
%  str =['res image ',num2str(figcounter),' SNR:',num2str(SNR(mainimage,y))];          %showing all patches
%  figure('Name',str,'NumberTitle','off');
%  imshow(residualimage);
% end
return;

% ========================================================
% ========================================================

function [A]=OMPerr(D,X,errorGoal)
% ========================================================
% Sparse coding of a group of signals based on a given dictionary and specified representation
% error to get.
% input arguments: D - the dictionary
%                           X - the signals to represent
%                           errorGoal - the maximal allowed representation error
% output arguments: A - sparse coefficient matrix.
% ========================================================
[n,P]=size(X);
[n,K]=size(D);
E2 = errorGoal^2*n;
maxNumCoef = n/2;
A = sparse(size(D,2),size(X,2));
h=waitbar(0,'OMP on each example ...');
for k=1:1:P,
    waitbar(k/P);
    a=[];
    x=X(:,k);
    residual=x;
    indx = [];
    a = [];
    currResNorm2 = sum(residual.^2);
    j = 0;
    while currResNorm2>E2 && j < maxNumCoef,
        j = j+1;
        proj=D'*residual;
        pos=find(abs(proj)==max(abs(proj)));
        pos=pos(1);
        indx(j)=pos;
        a=pinv(D(:,indx(1:j)))*x;
        residual=x-D(:,indx(1:j))*a;
        currResNorm2 = sum(residual.^2);
    end;
    if (~isempty(indx))
        A(indx,k)=a;
    end
end;
close(h); 
return;

% ========================================================
% ========================================================

function [yout]=RecoverImage(y,lambda,D,CoefMatrix)
% ========================================================
% ========================================================
N=size(y,1); 
n=sqrt(size(D,1)); 
yout=zeros(N,N); 
Weight=zeros(N,N); 
i=1; j=1;
for k=1:1:(N-n+1)^2,
    patch=reshape(D*CoefMatrix(:,k),[n,n]); 
    yout(i:i+n-1,j:j+n-1)=yout(i:i+n-1,j:j+n-1)+patch; 
    Weight(i:i+n-1,j:j+n-1)=Weight(i:i+n-1,j:j+n-1)+1; 
    if i<N-n+1 
        i=i+1; 
    else
        i=1; j=j+1; 
    end;
end;
yout=(yout+lambda*y)./(Weight+lambda); 
return;
