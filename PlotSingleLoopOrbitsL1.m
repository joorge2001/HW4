function [] = PlotSingleLoopOrbitsL1(xL1, d, mustar)
% -------------------------------------------------------------------------
% Function to plot single loop orbits around L1 starting at x0 position 
% (initial x position of the trajectory. It is an offset from the
% L1 point. x0 = xL1 - d).
%
% Inputs:
%     - xL1: x position of the Lagrange libration point (L1).
%     - d: offset distance from xL1.
%     - mustar: normalized mass of the smaller primary of the 3D body
%       problem: mustar = m2/(m1+m2)
%
% Outputs:
%     - Plots of single loop orbits around L1. 
% -------------------------------------------------------------------------


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


r1 = -mustar; % position of big planet
r2 = 1-mustar; % position of small planet

n = 5;
colorstring = 'kbgym';
figure()

for i = 1:5
    load(['Xd' num2str(i), '.mat']);
    x = X(:,1);
    y = X(:,2);
    x0 = xL1 - d(i);
    orbits(i) = plot(x,y,colorstring(i),'DisplayName',sprintf('d = %.3f',x0),'linewidth',1.2);
    
    hold on;
    plot(x, -y, colorstring(i), 'linewidth', 1.2);
    
end

hold on   
L1 = plot(xL1, 0,'o','MarkerFaceColor','r','MarkerEdgeColor','k');
hold on
smaller_primary = plot(r2, 0 ,'o','MarkerFaceColor','b','MarkerEdgeColor','k');

legend([orbits(1) orbits(2) orbits(3) orbits(4) orbits(5) L1 smaller_primary],...
    {'d = 0.010','d = 0.015','d = 0.020', 'd = 0.025', 'd = 0.030', 'L1 Point', 'Smaller Primary'})

title('Lyapunov Orbits: Position in $O_{xy}$ plane','FontSize',17);
xlabel('x')
ylabel('y')

legend('Location','eastoutside')
xlim([0.88 1.03])
grid minor

end