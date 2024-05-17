
function soled_comparacion_tiempo_muestreo(K, A, B, Tmin, Tmax, N)

% K - cte asociada a la magnitud de la entrada la ED
% A - cte en la ecuacion diferencial
% B - cte en la ecuacion diferencial
% Tmin - tiempo de muestreo mínimo
% Tmax - tiempo de muestreo máximo
% N - numero de muestras a evaluar

% Generar diferentes tiempos de muestreo en el rango especificado
T = linspace(Tmin, Tmax, N);

% ajustar a cero las variables de entrada x[n] y salida y[n]
y_atras = zeros(N, N+1);
y_adelante = zeros(N, N+1);
y_central = zeros(N, N+1);
x = ones(N, N+1);


% Ajuste por recursividad - Aproximación hacia adelante
for i = 1:N
    for cont = 1:N
        y_adelante(i, cont+1) = (1-((1/(A*B))*T(i)))*y_adelante(i, cont)+(T(i)/B)*x(i, cont+1);
    end
end

% Ajuste por recursividad - Aproximación hacia atrás
for i = 1:N
    for cont = 2:N+1
        y_atras(i, cont) = (1/(1+((1/(A*B))*T(i))))*y_atras(i, cont-1)+((T(i)/B)/(1+((1/(A*B))*T(i))))*x(i, cont);
    end
end

% Ajuste por recursividad - Aproximación central
for i = 1:N
    for cont = 2:N
        y_central(i, cont) = (1-((1/(2*A*B))*T(i)))*y_central(i, cont-1)+((T(i)/B)/(2*A))*x(i, cont+1)+((T(i)/B)/(2*A))*x(i, cont-1);
    end
end


% Dibujar las respuestas en un solo gráfico
figure;
hold on;

subplot(1, 3, 1)
for i = 1:N
    stem(0:N, y_atras(i, :));
end
xlabel('n');
ylabel('y[n]');
title('Aproximación hacia atrás');

subplot(1, 3, 2)
for i = 1:N
    stem(0:N, y_adelante(i, :));
end
xlabel('n');
ylabel('y[n]');
title('Aproximación hacia adelante');

subplot(1, 3, 3)
for i = 1:N
    stem(0:N, y_central(i, :));
end
xlabel('n');
ylabel('y[n]');
title('Aproximación central');

sgtitle(['Soluciones recursivas con un valor Tmin = ', num2str(Tmin), ', Tmax = ', num2str(Tmax), ' de muestreo']);
hold off;

