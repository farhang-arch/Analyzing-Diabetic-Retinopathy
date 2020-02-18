clear all
close all


M=3;
K=6;
L=[2 3 1];

index=zeros(2^(M*K),M*K);
smk=zeros(M,K,2^(M*K));

for i=1:2^(M*K)
    for j=1:M*K
        if j==1
        index(i,j)=mod(i-1,2);
        else
        index(i,j)=(mod(i-1,2^j)-mod(i-1,2^(j-1)))/2^(j-1);
        end
    end
end


for i=1:2^(M*K)
R(i,:,:)=reshape(squeeze(index(i,:)),M,K);
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
        for jj= J(1) : J(length(J))
        smj(mm,jj,rr)=R(rr,mm,jj)
        end
    end
end
