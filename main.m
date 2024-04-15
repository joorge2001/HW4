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

disp(xL1);

%% Part (b)

% X = [x,y,xdot,ydot]';

dX_dt = CR3BP(X,mustar);

% time = 1/sqrt(G*(m1+m2)/(r1+r2)^3);
% 
% x_0 = [0,y,0,ydot]';
