function dX_dt = CR3BP(X,mustar)

x = X(1);
y = X(2);
x_dot = X(3);
y_dot = X(4);

rho1 = sqrt((mustar + x)^2 + y^2);	% distance to primary
rho2 = sqrt((1 - mustar - x)^2 + y^2);	% distance to secondary

x_ddot = -(1-mustar)/rho1^3*(x+mustar) - mustar/rho2^3*(x+mustar-1) + x + 2*y_dot;
y_ddot = -(1-mustar)/rho1^3*y - mustar/rho2^3*y + y - 2*x_dot;

dX_dt = [x_dot; y_dot; x_ddot; y_ddot];

end