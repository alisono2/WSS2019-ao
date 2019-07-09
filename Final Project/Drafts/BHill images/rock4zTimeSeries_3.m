% Copyright 2018, All Rights Reserved
% Code by Alison Ord
% For rock 4z  Ord&Hobbs 2018; Ord et al. 2018

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./data');

% orchid system
dt=.00001;
%x1 = 8; x2 = 9; x3 = 25;
%x1=0.001; x2=0.001; x3=0.001;
x1=-0.001; x2=0.001; x3=-0.001

% Uses parameters derived thro' Brunton's code on rock4z
% x*220
for i = 500000 : 700000
x1 =  x1-0-(0.12*x1*dt)+(0.15*x2*dt)-(0.03*x3*dt);
x2 =  x2-0-(0.04*x1*dt)-(0.05*x2*dt)+(0.09*x3*dt);
x3 =  x3+0+(2.5*x1*dt)-(7.2*x2*dt)+(4.8*x3*dt)+(0.05*x1*x1*dt)-(0.07*x1*x2*dt)-(0.05*x1*x3*dt)+(0.03*x2*x2)+(0.03*x2*x3);
x(i,:) = [x1 x2 x3];
end

% plot phase space portrait
plot3(x(:,1),x(:,2),x(:,3))
grid, view(70,30)
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')

% plot variable over time
t = 0.01 : 0.01 : 1000;
plot(t,x(:,1))
xlabel('Time')
ylabel('Velocity')

% use only the first state and a time delay of six
tau = 6;
plot3(x(1:end-2*tau,1),x(1+tau:end-tau,1),x(1+2*tau:end,1))
grid, view([100 60])
xlabel('x_1'), ylabel('x_2'), zlabel('x_3')