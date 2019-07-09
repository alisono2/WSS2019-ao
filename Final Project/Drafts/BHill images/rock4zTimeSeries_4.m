% Copyright 2018, All Rights Reserved
% Code by Alison Ord
% For rock 4z  Ord&Hobbs 2018; Ord et al. 2018

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./data');

% orchid system
dt=.0001;
%x1 = 8; x2 = 9; x3 = 25;
%x1=0.001; x2=0.001; x3=0.001;
x1=-0.1; x2=0.1; x3=-0.1

% Uses parameters derived thro' Brunton's code on rock4z
% x*220
for i = 1 : 1000
x1 =  x1-.11-(0.26*x1*dt)+(3.2*x2*dt)-(0.06*x3*dt);
x2 =  x2-0-(0.47*x1*dt)+(170.*x2*dt)-(123.*x3*dt)+(-.3*x1*x2*dt)+(0.8*x1*x3*dt)-(0.4*x2*x2*dt);
x3 =  x3+542.-(2860.*x1*dt)-(3130.*x2*dt)+(6122.*x3*dt)+(9002.*x1*x1*dt)-(1323.*x1*x2*dt)-(4739.*x1*x3*dt)-(4307.*x2*x2);
x(i,:) = [x1 x2 x3];
end

% plot phase space portrait
plot3(x(:,1),x(:,2),x(:,3))
grid, view(70,30)
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')

% use only the first state and a time delay of six
tau = 6;
plot3(x(1:end-2*tau,1),x(1+tau:end-tau,1),x(1+2*tau:end,1))
grid, view([100 60])
xlabel('x_1'), ylabel('x_2'), zlabel('x_3')