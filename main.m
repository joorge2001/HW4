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

x0 = 2*(r1+r2)/3;
% x0 = 0.9;
xL1 = fzero(f,x0);

fprintf('The position of the first Lagrange libration point (L1) along the x axis is %f\n', xL1);

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

X0 = [xL1;0;0;0.085]; % initial state vector

dt = 0.001;

xdtof = shoot(X0(1), X0(4), mustar, dt);

dt_vector = [0.05, 0.01, 0.01, 0.005, 0.001, 0.0005, 0.0001];

% Dt analysis 
PlotYfvsDt(X0(1), X0(4), mustar,dt_vector)


%% Part (e)
% Left and right boundaries for exploration of solutions with the secant method
% These have been selected manually (trial and error) to get propper results 
ydotL_vec = [0.085 0.138 0.171 0.191 0.205];
ydotR_vec = [0.088 0.139 0.172 0.192 0.206];

d = [0.01 0.015 0.02 0.025 0.03]; % distance to Lagrange Point (L1)
dt_secant = 10e-4; % time step used for secant method


for i = 1:length(d)
    x0 = xL1 - d(i); % distance to the left of the L1 point
    
    f = @(ydot0) shoot(x0,ydot0,mustar,dt_secant);
    ydotL = ydotL_vec(i);
    ydotR = ydotR_vec(i);
    
    % Secant method: finds ydot0 that makes x_dot component zero, when
    % crossing x-axis
    ydot0_sec = secant(f,ydotL,ydotR);
    
    xdotf(i) = shoot(x0,ydot0_sec,mustar,dt);
    
    % Save the data in order to plot it afterwards (this is done to avoid
    % to run the code as it takes a while)
    X = get_Xf(x0,ydot0_sec,mustar,dt); % Get all state vector for the trajectory
     
    % Save inital and final state vector in a data structure
    save X0XfinalAlld.mat % Save all data in a 
    X0XfinalAlld.X0(:,i) = [x0 0 0 ydot0_sec]'; % Save initial state vector as 
    X0XfinalAlld.Xfinal(:,i) = [X(end, 1); X(end, 2); xdotf(i); X(end, 3)]; % Final state vector
    
    % Save full trajectory state vector in a .mat file
    X_whole = ['Xd' num2str(i),'.mat'];
    save(X_whole,'X'); % save variable 
    
end


%% Plot single loop orbits around L1

clc; close all;

PlotSingleLoopOrbitsL1(xL1, d, mustar)

