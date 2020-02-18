% Rising Tide check for lognormal dist
clc
clear
close all

a = input('enter a num = ');
switch a
    case 2
        fun=@(x) -(2*log(x(1)+x(3))/(x(1)+x(3)))-(2*log(x(2)+x(3))/(x(2)+x(3)))+...
            (log(x(1)+x(3))+log(x(2)+x(3)))*(1/(x(1)+x(3))+1/(x(2)+x(3)));
        A=[];
        b=[];
        Aeq=[];
        beq=[];
        lb=[eps,eps,eps];
        ub=[Inf,Inf,Inf];
        x0=[eps,eps,eps];
        x=fmincon(fun,x0,A,b,Aeq,beq,lb,ub);
    case 3
        fun=@(x) -(3*log(x(1)+x(4))/(x(1)+x(4)))-(3*log(x(2)+x(4))/(x(2)+x(4)))-...
            (3*log(x(3)+x(4))/(x(3)+x(4)))+(log(x(1)+x(4))+log(x(2)+x(4))+log(x(3)+x(4)))*...
            (1/(x(1)+x(4))+1/(x(2)+x(4))+1/(x(3)+x(4)));
        A=[];
        b=[];
        Aeq=[];
        beq=[];
        lb=[eps,eps,eps,eps];
        ub=[Inf,Inf,Inf,Inf];
        x0=[eps,eps,eps,eps];
        x=fmincon(fun,x0,A,b,Aeq,beq,lb,ub);
    case 4
        fun=@(x) -(4*log(x(1)+x(5))/(x(1)+x(5)))-(4*log(x(2)+x(5))/(x(2)+x(5)))-...
            (4*log(x(3)+x(5))/(x(3)+x(5)))-(4*log(x(4)+x(5))/(x(4)+x(5)))+...
            (log(x(1)+x(5))+log(x(2)+x(5))+log(x(3)+x(5))+log(x(4)+x(5)))*...
            (1/(x(1)+x(5))+1/(x(2)+x(5))+1/(x(3)+x(5))+1/(x(4)+x(5)));
        A=[];
        b=[];
        Aeq=[];
        beq=[];
        lb=[eps,eps,eps,eps,eps];
        ub=[Inf,Inf,Inf,Inf,Inf];
        x0=[eps,eps,eps,eps,eps];
        x=fmincon(fun,x0,A,b,Aeq,beq,lb,ub);
end

