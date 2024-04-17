function y = secant(f,y1,y2)
% -------------------------------------------------------------------------
% Function which finds the solution of the function f(y) given two intial
% guesses. 
%
% Inputs: 
%     - f: function to be solved, f(y).
%     - y1: intial guess 1.
%     - y2: intial guess 2.
%
% Outputs:
%     - y: final solution of f(y)=0 problem. 
% -------------------------------------------------------------------------
tol = 1e-3;
ftol = 1e-3;
nmax = 1000;

for k = 1:nmax
    
    fy = f(y1);
    dfy = (f(y2)-f(y1))/(y2-y1);
    y = y1 - fy/dfy;
    
    errf = abs(fy);
    errf1 = abs(y1);
    errf2 = abs(y-y1);
    
    % check if y is the root
    % we want to fulfill both criteria: abs(fy) < ftol and abs(y-y0)< tol(1+abs(y0))
    % if y is the root assign y, n and errf, and exit
    % if y is not the root --> assign y0 for the next iteration
    
    if  errf < ftol && errf2< tol*(1+errf1)
        n = k;
        return
    else
        y1 = y2;
        y2 = y;
    end
    
end

disp('Sorry, but no root was found. Try a better initial guess.');
y = NaN;

end