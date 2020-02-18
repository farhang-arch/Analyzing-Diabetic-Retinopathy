function s = sparse_model(A,a)

% A should be a one dimensional vector
% case
%   0: exponential dist
%   1: normal dist
%   2: uniform dist [0,teta]
%   3: lognormal dist
%   4: poisson dist
A = abs(A);
l=length(A);
switch a
    case 0
        alpha=mle(A,'distribution','exp');
        mu_estimated=alpha;
        var_estimated=alpha^2;
        s=(var_estimated)/(mu_estimated)^2;
    case 1
        phat=mle(A,'distribution','norm');
        mu_estimated=phat(1);
        var_estimated=phat(2)^2;
        s=(var_estimated)/(mu_estimated)^2;
    case 2
        teta=mle(A,'distribution','unid');
        mu_estimated=0.5*teta;
        var_estimated=(teta)^2/12;
        s=(var_estimated)/(mu_estimated)^2;
    case 3
        phat=mle(A,'distribution','logn');
        mu_estimated=phat(1);
        var_estimated=phat(2)^2;
        mean=exp(mu_estimated + 0.5*var_estimated);
        var_n=(exp(2*mu_estimated + var_estimated))*(exp(var_estimated)-1);
        s=(var_n)/(mean^2);
    case 4
        phat=mle(A,'distribution','poiss');
        mu_estimated=phat;
        var_estimated=phat;
        s=(var_estimated/mu_estimated^2);
end
end

