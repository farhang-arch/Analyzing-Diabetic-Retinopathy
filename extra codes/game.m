clc
clear
close all

% Monte carlo simulation of games;
initial_money=10000;
bets=100;
num_plays=40;
t=51;
remain_money=initial_money;
for i=1:num_plays
    dice=unidrnd(100);
    casion_edge=condition( dice, t );
    remain_money=remain_money+(casion_edge*bets);
end
out=remain_money;

