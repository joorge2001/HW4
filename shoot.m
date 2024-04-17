function xdotf = shoot(x0,ydot0,mustar,dt)
% -------------------------------------------------------------------------
% Function which finds the final velocity x_dot for a given intial trajectory. 
% The solution is found whenever y crosses the x axis.
%
% Inputs: 
%     - x0: initial x position of the trajectory.
%     - ydot0: inital y velocity of the trajectory.
%     - mustar: normalized mass of the smaller primary of the 3D body
%       problem: mustar = m2/(m1+m2)
%     - dt: time step for the integration.

% Outputs:
%     - xdotf: final x velocity of the trajectory. 
% -------------------------------------------------------------------------


X0 = [x0; 0; 0; ydot0]; % Recover initial state vector
dX_dt = @(t,X) CR3BP(X,mustar); % Create anonymous function


% Integrate one step at a time to identify crossing
times = 0:dt:3;
nsteps = length(times)-1;


for i = 1:nsteps
    
    steps = times(1:i+1);
    [t,X] = RK4(dX_dt,steps,X0);
    
    if X(i+1, 2) <= 0        % Identify crossing
        xdotf = X(end,3);    % Identify value of x_dot at crossing
        % X(end,2) % y value
        return
    end
        
end


end

