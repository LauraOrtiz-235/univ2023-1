
function soled_diferencias(K, A, B, T, N)

% K - cte asociada a la magnitud de la entrada la ED
% A - cte en la ecuacion diferencial
% B - cte en la ecuacion diferencial
% T - tiempo de muestreo deseado
% N - numero de muestras a evaluar

% ajustar a cero las variables de entrada x[n] y salida y[n]
y = zeros(1, N+1);
x = ones(1, N+1);

% ajuste por recursividad aproximacion adelante 
for cont = 1:1:N
    y(1, cont+1) = (1 - ((1 / (A*B)) * T))*y(1, cont) + (T/B)*x(1, cont+1);
    stem(cont+1, y(1, cont+1));
    hold on; 
    drawnow;
end
