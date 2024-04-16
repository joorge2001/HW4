function [] = examplePlots(times,X,t_ode45,X_ode45)

figure;
sgtitle('Evolution of x, y, $\dot{x}$ and $\dot{y}$ over time','Interpreter','latex') 
subplot(2,2,1)
plot(times,X(:,1),'r');
hold on;
plot(t_ode45,X_ode45(:,1),'b');
legend('RK4','ode45','Location','best')
xlabel('t [-]')
ylabel('x')

subplot(2,2,2)
plot(times,X(:,2),'r')
hold on;
plot(t_ode45,X_ode45(:,2),'b');
legend('RK4','ode45','Location','best')
xlabel('t [-]')
ylabel('y')

subplot(2,2,3)
plot(times,X(:,3),'r')
hold on;
plot(t_ode45,X_ode45(:,3),'b');
legend('RK4','ode45','Location','best')
xlabel('t [-]')
ylabel('$\dot{x}$','Interpreter','latex')

subplot(2,2,4)
plot(times,X(:,4),'r')
hold on;
plot(t_ode45,X_ode45(:,4),'b');
legend('RK4','ode45','Location','best')
xlabel('t [-]')
ylabel('$\dot{y}$','Interpreter','latex')
hold off

figure;
sgtitle('Positions and velocities in the x-y plane','Interpreter','latex') 
subplot(1,2,1)
plot(X(:,1),X(:,2),'r')
hold on;
plot(X_ode45(:,1),X_ode45(:,2),'b');
legend('RK4','ode45','Location','best')
xlabel('x')
ylabel('y','Interpreter','latex')

subplot(1,2,2)
plot(X(:,3),X(:,4),'r')
hold on;
plot(X_ode45(:,3),X_ode45(:,4),'b');
legend('RK4','ode45','Location','best')
xlabel('$\dot{x}$','Interpreter','latex')
ylabel('$\dot{y}$','Interpreter','latex')
hold off

end