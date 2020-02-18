function [ x ] = curve_array( cz )

curve_1=cz{1}{1};
q=size(curve_1);
u=reshape(curve_1,1,q(1)*q(2));

y=[];
for i=1:16
    curve=cz{2}{i};
    p=size(curve);
    curve_re=reshape(curve,1,p(1)*p(2));
    t=curve_re;
    y=[y t];
end

x=[u y];

end

