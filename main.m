%%-------- Homework 4: Space Vehicles and Orbital Dynamics --------

% Authors: 
%   - Jaume Manresa Rigo (100461930)
%   - Jorge Cortés de Jesús (100428594)

%%
clear; clc; 
close all;

%% Format settings

set(groot, 'defaultLegendFontSize', 20);
set(groot, 'defaultTextFontSize', 20);
set(groot, 'defaultAxesFontSize', 20);
set(groot, 'defaultAxesLineWidth', 1);
set(groot, 'defaultAxesXMinorTick', 'on');
set(groot, 'defaultAxesYMinorTick', 'on');
set(groot, 'defaultLegendBox', 'off');
set(groot, 'defaultLegendLocation', 'best');
set(groot, 'defaultLineLineWidth', 1);
set(groot, 'defaultLineMarkerSize', 10);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

%% Part (a)
G = 6.67260e-11; % [m^3/(kg*s^2)]

mustar = 0.001;

%initial condition: x = 0; xdot = 0

m1 = 1- mustar;
m2 = mustar;

r1 = -mustar;
r2 = 1-mustar;

% in the frame of reference of the line connecting the bodies, y = 0

% rho1 = abs(xL1 + mustar);
% rho2 = abs(xL1 - 1 + mustar);
% abs due to the modulus
f = @(xL1) -(1-mustar)/abs(xL1+mustar)^3*(xL1+mustar) - mustar/abs(xL1-1+mustar)^3*(xL1-1+mustar) + xL1;

x0 = (r1+r2)/2;
% x0 = 0.9;
xL1 = fzero(f,x0);

fprintf('The position of the first Lagrange libration point, L1 is %f ',xL1);

%% Part (b) and (c)

% X = [x;y;xdot;ydot];

X0 = [xL1;0;0;0.5];

% time = 1/sqrt(G*(m1+m2)/(r12)^3); adimensionalized t = [0,1]

times = 0:1e-4:1;

f = @(t,X) CR3BP(X,mustar);

[t,X] = RK4(f,times,X0);

[t_ode45,X_ode45] = ode45(f,times,X0);

figure;
plot(times,X(:,1),'r');
hold on;
plot(times,X_ode45(:,1),'b');
legend('RK4','ode45')
xlabel('t [-]')
ylabel('x')

figure;
plot(times,X(:,2),'r')
hold on;
plot(times,X_ode45(:,2),'b');
legend('RK4','ode45')
xlabel('t [-]')
ylabel('y')

figure;
plot(times,X(:,3)','r')
hold on;
plot(times,X_ode45(:,3),'b');
legend('RK4','ode45')
xlabel('t [-]')
ylabel('$\dot{x}$')

figure;
plot(times,X(:,4)','r')
hold on;
plot(times,X_ode45(:,4),'b');
legend('RK4','ode45')
xlabel('t [-]')
ylabel('$\dot{x}$')

%%  Part (d)

