function [t,X] = RK4(f,times,X0)
%
%   This function uses a 4-stage Runge-Kutta method to solve a system of   
%   1st order ODEs of type:
%   
%   y_1' = f_1(y_1,y_2,...,y_n,t)
%   y_2' = f_2(y_1,y_2,...,y_n,t)
%               .
%               .
%               .
%   y_n' = f_n(y_1,y_2,...,y_n,t)
%
% Inputs: 
%     - f: vector with the function handles of each equation
%     - times: discrete time instants at which the solution is requested
%     - X0: initial condition vector introduced as a column 
%           vector [y(t=t0); y'(t=t0); ... y^n(t=t0)]
%     
% Outputs:
%     - t: discretized time vector equal to the input vector "times"
%     - X: solution vector
% -------------------------------------------------------------------------

% Allocate the solution vector

t(:,1) = times;
N = length(t);

X = zeros(length(X0),N);

% Set the initial condition
X(:,1) = X0;

% Compute the solution 
for n = 2:N   
    dt = t(n) - t(n-1);

    U2 = X(:,n-1) + dt/2 * f(t(n-1),X(:,n-1));
    U3 = X(:,n-1) + dt/2 * f(t(n-1)+dt/2,U2);
    U4 = X(:,n-1) + dt * f(t(n-1)+dt/2,U3);
    X(:,n) = X(:,n-1) + dt/6 * ...
        (f(t(n-1),X(:,n-1)) + ...
        2*f(t(n-1)+dt/2,U2) +...
        2*f(t(n-1)+dt/2,U3) +...
        f(t(n-1)+dt,U4));
end
X = X';
end