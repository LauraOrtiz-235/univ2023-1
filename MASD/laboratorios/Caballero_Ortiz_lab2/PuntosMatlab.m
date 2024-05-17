 clear
clc

% PUNTO 3 d.

D0 = 2;
p = 0.25;
t = 25; % # de horas para simular
D = zeros(1,t);

D(1) = D0;

for k = 1:t
    D(k+1) = D(k) + D0 - D(k)*p;
end

figure

stem(D, ':diamondr')
xlabel('Tiempo (h)')
ylabel('Cantidad de droga (cc)')
title('Evolución de la cantidad de droga en sangre')

%%

% PUNTO 4 c.

x0 = 80000;
i = 0.01;
p = 960.13;
t = 180; % 15 años
x = zeros(1,t);

x(1) = x0;

for k = 1:t
    x(k+1) = (1 + i)*x(k) - p;
end

disp(x(t))

figure

plot(0:180, n)
xlabel('Meses')
ylabel('Saldo del préstamo')
