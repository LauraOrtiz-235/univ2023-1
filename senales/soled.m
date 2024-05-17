
function soled(K, A, B)

% K - cte asociada a la magnitud de la entrada la ED
% A - cte en la ecuacion diferencial
% B - cte en la ecuacion diferencial

% vector de tiempo
t = 0:0.0001:(7*A*B);

% vector de la variable dependiente
y = K*A-K*A*exp(-(1 / (A*B)) * t);

% dibujo de la señal en tiempo continuo
plot(t,y);
title('Salida de la Ecuacion Diferencial')
xlabel('Segundos')
ylabel('Unidades')