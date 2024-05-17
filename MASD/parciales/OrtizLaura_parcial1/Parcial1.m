
%%%%%%%%%%%%%%%%%% PARCIAL 1 %%%%%%%%%%%%%%%%%%

% Punto 4
% a).

% Parámetros de la simulación
A = 50;     
k = 0.5;    
L0 = 1;     
tmax = 12;  % Tiempo máximo de 12 meses

% Eq diferencial
dL = @(t,L) k*(A - L);

% Solución de la eq
[t,L] = ode45(dL, [0,tmax], L0);

% Gráfica de la evolución de la talla
plot(t,L, 'b');
legend({'y = crecimiento del pez'},'Location','southwest')
xlabel('Tiempo (meses)');
ylabel('Talla');
title('Simulación de la evolución de la talla de un pez');

%%

% b). Cuál es la talla del pez a los 6 meses?

% Parámetros de la simulación
A = 50;     
k = 0.5;    
L0 = 1;     
tmax = 12;              % Tiempo máximo de 12 meses
dt = 0.01;              % Paso de tiempo
t2 = 0:dt:tmax;          % Vector de tiempo
L_1 = L0;                 % Inicialización de talla

% Eq diferencial
dL = @(t,L) k*(A - L);

% Solución de la eq
[t,L] = ode45(dL, [0,tmax], L0);

% Conocer la talla en meses
for i = 1:length(t2)-1
    L_1(i+1) = L_1(i) + k*(A - L_1(i))*dt;   
end

% Talla a los 6 meses
t_6meses = 6; 
L_6meses = interp1(t2, L_1, t_6meses);    
disp(['La talla del pez a los 6 meses es: ', num2str(L_6meses)]);

% Gráfica de la evolución de la talla
plot(t, L, 'b');
legend({'y = crecimiento del pez'},'Location','southwest')
xlabel('Tiempo (meses)');
ylabel('Talla');
title('Simulación de la evolución de la talla de un pez');

% Según el resultado arrojado y la gráfica, podemos ver que la talla
% del pez a los 6 meses, es de: 47.5787
