function [] = PlotYfvsDt(x0,ydot0,mustar,dt_vector)
% -------------------------------------------------------------------------
% Function to plot final Y value versus different time steps.
%
% Inputs: 
%     - x0: initial x position of the trajectory.
%     - ydot0: inital y velocity of the trajectory.
%     - mustar: normalized mass of the smaller primary of the 3D body
%       problem: mustar = m2/(m1+m2)
%     - dt_vector: time step vector for the analysis.

% Outputs:
%     - Plots for the analysis.
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

figure();

for i=1:length(dt_vector)
    Xf = get_Xf(x0,ydot0,mustar,dt_vector(i));
    y(i) = Xf(end, 2);
end

loglog(dt_vector, y)
title('Shooting Method: $y_f$ vs $\Delta t$')
xlabel('$\Delta t$')
ylabel('$y_f$')

xlim([dt_vector(end) dt_vector(1)])

end

