% Copyright 2018
% Code by Alison Ord
% based on rocks analysed in 2017/2018   JSG   PhilTransA

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./data');

%% generate Data
polyorder = 5;
usesine = 0;

n = 3;

% Integrate
% you need to load x as well as dx
load -ascii rock4z_x.txt
x=99*rock4z_x;
%N = length(x);
load -ascii rock4z_dx.txt
dx=217*rock4z_dx;
N = length(dx);

%% compute Derivative

%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;      % lambda is our sparsification knob.
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y','z'},Xi,n,polyorder,usesine);

plot(x(:,1),x(:,3))
%grid, view(70,30)
xlabel('x_1')
ylabel('x_2')

plot3(dx(:,1),dx(:,2),dx(:,3))
grid, view(70,30)
xlabel('dx_1')
ylabel('dx_2')
zlabel('dx_3')

%% FIGURE 1:  LORENZ for T\in[0,20]
tspan = [0 20];
[tA,xA]=ode45(@(t,x)lorenz(t,x,sigma,beta,rho),tspan,x0,options);   % true model
[tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspan,x0,options);  % approximate

figure
subplot(1,2,1)
dtA = [0; diff(tA)];
color_line3(xA(:,1),xA(:,2),xA(:,3),dtA,'LineWidth',1.5);
view(27,16)
grid on
xlabel('x','FontSize',13)
ylabel('y','FontSize',13)
zlabel('z','FontSize',13)
set(gca,'FontSize',13)
subplot(1,2,2)
dtB = [0; diff(tB)];
color_line3(xB(:,1),xB(:,2),xB(:,3),dtB,'LineWidth',1.5);
view(27,16)
grid on

% Lorenz for t=20, dynamo view
figure
subplot(1,2,1)
plot(tA,xA(:,1),'k','LineWidth',1.5), hold on
plot(tB,xB(:,1),'r--','LineWidth',1.5)
grid on
xlabel('Time','FontSize',13)
ylabel('x','FontSize',13)
set(gca,'FontSize',13)
subplot(1,2,2)
plot(tA,xA(:,2),'k','LineWidth',1.5), hold on
plot(tB,xB(:,2),'r--','LineWidth',1.5)
grid on


%% FIGURE 1:  LORENZ for T\in[0,250]
tspan = [0 250];
options = odeset('RelTol',1e-6,'AbsTol',1e-6*ones(1,n));
[tA,xA]=ode45(@(t,x)lorenz(t,x,sigma,beta,rho),tspan,x0,options);   % true model
[tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspan,x0,options);  % approximate

figure
subplot(1,2,1)
dtA = [0; diff(tA)];
color_line3(xA(:,1),xA(:,2),xA(:,3),dtA,'LineWidth',1.5);
view(27,16)
grid on
xlabel('x','FontSize',13)
ylabel('y','FontSize',13)
zlabel('z','FontSize',13)

subplot(1,2,2)
dtB = [0; diff(tB)];
color_line3(xB(:,1),xB(:,2),xB(:,3),dtB,'LineWidth',1.5);
view(27,16)
grid on
xlabel('x')
ylabel('y')
zlabel('z')