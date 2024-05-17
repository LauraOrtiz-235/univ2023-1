 
%% PUNTO 2

t0 = 0;
tf = 10;
x0 = 1;

[t,x] = ode45(@ODEx, [t0,tf], x0)

plot(t,x)
title('Solución de la ecuación diferencial')
