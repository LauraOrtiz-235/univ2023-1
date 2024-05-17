
% Cargar las señales
load('Tarea1_ProcSenal.mat');


y1_d = fft_diezmado(y1);
y2_d = fft_diezmado(y2);
y3_d = fft_diezmado(y3);


% Graficar las señales originales
figure;
subplot(3, 1, 1);
stem(t, y1);
title('Señal 1 Original');

subplot(3, 1, 2);
stem(t, y2);
title('Señal 2 Original');

subplot(3, 1, 3);
stem(t, y3);
title('Señal 3 Original');


% Graficar las señales usando la funcion fft_diezmado y la de matlab, 
% para comparar que sean iguales y el algoritmo funcione bien
figure;
subplot(2, 3, 1);
stem(t, y1_d);
title('Señal 1, usando la funcion creada de FFT Diezmado');

subplot(2, 3, 2);
stem(t, y2_d);
title('Señal 2, usando la funcion creada de FFT Diezmado');

subplot(2, 3, 3);
stem(t, y3_d);
title('Señal 3, usando la funcion creada de FFT Diezmado');


subplot(2, 3, 4);
stem(t, fft(y1));
title('Señal 1, después de usar FFT de Matlab');

subplot(2, 3, 5);
stem(t, fft(y2));
title('Señal 2, después de usar FFT de Matlab');

subplot(2, 3, 6);
stem(t, fft(y3));
title('Señal 3, después de usar FFT de Matlab');

