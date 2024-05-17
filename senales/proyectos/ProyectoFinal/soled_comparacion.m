
function soled_comparacion(K, A, B, T, N)

% K - cte asociada a la magnitud de la entrada la ED
% A - cte en la ecuacion diferencial
% B - cte en la ecuacion diferencial
% T - tiempo de muestreo deseado
% N - numero de muestras a evaluar

% ajustar a cero las variables de entrada x[n] y salida y[n]
y_atras = zeros(1, N+1);
y_adelante = zeros(1, N+1);
y_central = zeros(1, N+1);
x = ones(1, N+1);


% Ajuste por recursividad - Aproximación hacia adelante
for cont = 1:1:N
    y_adelante(1, cont+1) = (1-((1/(A*B))*T))*y_adelante(1, cont)+(T/B)*x(1, cont+1);
end

% Ajuste por recursividad - Aproximación hacia atrás
for cont = 2:N+1
    y_atras(1, cont) = (1/(1+((1/(A*B))*T)))*y_atras(1, cont-1)+((T/B)/(1+((1/(A*B))*T)))*x(1, cont);
end

% Ajuste por recursividad - Aproximación central
for cont = 2:N
    y_central(1, cont) = (1-((1/(2*A*B))*T))*y_central(1, cont-1)+((T/B)/(2*A))*x(1, cont+1)+((T/B)/(2*A))*x(1, cont-1);
end


% Dibujar las respuestas en un solo gráfico
figure;
hold on;
stem(0:1:N, y_atras, 'DisplayName', 'Aproximación Atrás');
stem(0:1:N, y_adelante, 'DisplayName', 'Aproximación Adelante');
stem(0:1:N, y_central, 'DisplayName', 'Aproximación Central');
hold off;

legend;
xlabel('n');
ylabel('y[n]');
title('Soluciones recursivas con diferentes aproximaciones de diferencia');
grid on;

