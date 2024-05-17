
%%%%%%%%%% 2.2.1 Simple sampled signals %%%%%%%%%%
clc;

fs = 8000;           
n = 1000;            
f = 400;             
t = linspace(0, (n-1)/fs, n);    

% Genrar la señal
x = sin(2*pi*f*t);   
% FFT
hx = fft(x, n);      
hx = fftshift(hx);   

% Vector de frecuencia
fHz = linspace(-fs/2, fs/2, n); 

% Grafica
stem(fHz, abs(hx));  
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 400 Hz sine wave');


% PREGUNTAS:

% - Is this what you expected?

% Podemos ver que la gráfica muestra la magnitud de la DFT centrada en el 
% eje de frecuencia en Hz. La gráfica tiene un pico aprox. en la frecuencia
% de 400 Hz, lo que es lo que esperamos.


%%
clc;

fs = 8000;           
n = 1000;            
f = 401; 
f2 = 402;
t = linspace(0, (n-1)/fs, n);    

% Genrar la señal
x = sin(2*pi*f*t);
x2 = sin(2*pi*f2*t);

% FFT
hx = fft(x, n);      
hx = fftshift(hx);   
hx2 = fft(x2, n);      
hx2 = fftshift(hx2); 

% Vector de frecuencia
fHz = linspace(-fs/2, fs/2, n); 

% Grafica
subplot(2,1,1);
stem(fHz, abs(hx));  
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 401 Hz sine wave');

subplot(2,1,2);
stem(fHz, abs(hx2));  
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 402 Hz sine wave');


%%
clc;

fs = 8000;           
n = 1000;            
f = 440; 
t = linspace(0, (n-1)/fs, n);    

% Genrar la señal
x = sin(2*pi*f*t);

% FFT
hx = fft(x, n);      
hx = fftshift(hx);    

% Vector de frecuencia
fHz = linspace(-fs/2, fs/2, n); 

% Grafica
stem(fHz, abs(hx));  
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 440 Hz sine wave');


% PREGUNTAS:

% - What about 440Hz?, What is happening?

% La grafica tiene un pico aprox. en la frecuencia de 440Hz en la FFT, esto
% puede significar que la señal solo contiene una componente espectral en 
% 440Hz y no tiene armónicos superiores.


%%
clc;

fs = 8000;           
n = 1000;            
f = 400; 
f2 = 440;
t = linspace(0, (n-1)/fs, n);    

% Genrar la señal
x = sin(2*pi*f*t);   
x2 = sin(2*pi*f2*t);

% FFT
hx = fft(x, n);      
hx = fftshift(hx);   

hx2 = fft(x2, n);      
hx2 = fftshift(hx2);  

% Vector de frecuencia
fHz = linspace(-fs/2, fs/2, n); 

% Grafica 400Hz
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('400 Hz sine wave');

subplot(2,1,2);
stem(fHz, abs(hx));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 400 Hz sine wave');

% Grafica 440Hz
figure;
subplot(2,1,1);
plot(t, x2);
xlabel('Time (s)');
ylabel('Amplitude');
title('440 Hz sine wave');

subplot(2,1,2);
stem(fHz, abs(hx2));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 440 Hz sine wave');


% PREGUNTAS:

% - What is special about 400Hz and 440Hz?

% Luego de graficar sus señales sinusoidales, podemos ver que ambas 
% frecuencias están relacionadas con notas musicales, corresponden a unas 
% notas en el sistema de afinación estándar A440. Esto significa que estas 
% frecuencias son utilizadas como referencia para la afinación de 
% instrumentos y son ampliamente utilizadas en la música.


%%
clc;

fs = 8000;           
n = 3000;            
f = 400; 
f2 = 440;
t = linspace(0, (n-1)/fs, n);    

% Genrar la señal
x = sin(2*pi*f*t);   
x2 = sin(2*pi*f2*t);

% FFT
hx = fft(x, n);      
hx = fftshift(hx);   

hx2 = fft(x2, n);      
hx2 = fftshift(hx2);  

% Vector de frecuencia
fHz = linspace(-fs/2, fs/2, n); 

% Grafica 400Hz
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('400 Hz sine wave');

subplot(2,1,2);
stem(fHz, abs(hx));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 400 Hz sine wave');

% Grafica 440Hz
figure;
subplot(2,1,1);
plot(t, x2);
xlabel('Time (s)');
ylabel('Amplitude');
title('440 Hz sine wave');

subplot(2,1,2);
stem(fHz, abs(hx2));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude of DFT of 440 Hz sine wave');


% PREGUNTAS:

% - Try changing the number of points in the FFT, 
% how does this affect the plot?

% Aumentar el número de puntos en la FFT proporciona una mejor resolución 
% espectral, pero también aumenta el tiempo de procesamiento y disminuye 
% la frecuencia de muestreo efectiva. 
% Reducir el número de puntos en la FFT reduce el tiempo de procesamiento, 
% pero disminuye la resolución espectral y puede ocultar información en las
% frecuencias cercanas.
% Esto se puede observar en el codigo anterior al cambiar n.


%%
clc;

fs = 8000; 
n = 1024;
n2 = 2048;
n3 = 4096;
t = (0:1023)/fs; 

% Señal
x = sin(2*pi*400*t) + 0.5*sin(2*pi*420*t) + 0.25*sin(2*pi*440*t); 

% Vectores de frecuencia
fHz = linspace(-fs/2, fs/2, n); 
fHz2 = linspace(-fs/2, fs/2, n2); 
fHz3 = linspace(-fs/2, fs/2, n3); 

% Grafica para 1024
figure;
subplot(3,1,1);
stem(fHz, abs(fftshift(fft(x,n))));
title('DFT of x(t) using 1024 sample points');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');

% Grafica para 2048
subplot(3,1,2);
stem(fHz2, abs(fftshift(fft(x,n2))));
title('DFT of x(t) using 2048 sample points');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');

% Grafica para 4096
subplot(3,1,3);
stem(fHz3, abs(fftshift(fft(x,n3))));
title('DFT of x(t) using 4096 sample points');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');


% PREGUNTAS:

% - What does this tell us about how to sample a signal and interpret 
% the DFT?

% Los resultados obtenidos de la DFT de la señal indican que la cantidad de
% muestras utilizadas en la DFT afecta significativamente la resolución de 
% frecuencia y la precisión del análisis. 
% Por lo tanto, es importante elegir un número apropiado de muestras en 
% función de la resolución de frecuencia deseada y los recursos 
% computacionales. Esto enfatiza la importancia de las técnicas de muestreo
% y el procesamiento de señales adecuados para interpretar con precisión 
% la DFT de una señal.

