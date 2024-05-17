
function muestreo

fs = 4000;
t = 0:1/fs:1/60;

y = sin(377*t);

figure;
stem(t, y);
title('Grafica de la señal x(t) = sin(377t)');


% Verificación de si el número de muestras es múltiplo de 2^n
N = length(y);

if log2(N) == floor(log2(N))
    disp('El número de muestras de la señal es múltiplo de 2^n');
else
    disp('El número de muestras de la señal no es múltiplo de 2^n');
end

