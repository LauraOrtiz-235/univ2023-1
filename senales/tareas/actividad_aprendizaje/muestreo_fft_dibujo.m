
function muestreo_fft_dibujo

% se establece la frecuencia de muestreo 
frecsam=[120 600 1000 100000];


% contrucción del eje de tiempo
tiempo.caso1=0:1/frecsam(1):1/60; 
tiempo.caso2=0:1/frecsam(2):1/60;
tiempo.caso3=0:1/frecsam(3):1/60; 
tiempo.caso4=0:1/frecsam(4):1/60;


% construcción de la señal
y.caso1=sin(377*tiempo.caso1); 
y.caso2=sin(377*tiempo.caso2); 
y.caso3=sin(377*tiempo.caso3);
y.caso4=sin(377*tiempo.caso4);


% trasnformada de fourier para los diferentes tiempo de muestreo 
% para fm=120Hz
fourier.caso1 = fft(y.caso1); % algoritmo fft
l_fou.caso1 = length(fourier.caso1); %longitud del vector 
abs_fou.caso1 = 0.5*abs(fourier.caso1) / (l_fou.caso1 / 2); % valor absoluto de la FFT
delta_frec.caso1 = frecsam(1) / l_fou.caso1; %delta de frecuencia 
eje_frec.caso1 = (0:1:l_fou.caso1 - 1)*delta_frec.caso1; %eje de frecuencia

% para fm=600Hz
fourier.caso2 = fft(y.caso2); % algoritmo fft
l_fou.caso2 = length(fourier.caso2); %longitud del vector 
abs_fou.caso2 = 0.5*abs(fourier.caso2) / (l_fou.caso2 / 2); % valor absoluto de la FFT
delta_frec.caso2 = frecsam(2) / l_fou.caso2; %delta de frecuencia 
eje_frec.caso2 = (0:1:l_fou.caso2 - 1)*delta_frec.caso2; %eje de frecuencia

% para fm=1000Hz
fourier.caso3 = fft(y.caso3); % algoritmo fft
l_fou.caso3 = length(fourier.caso3); %longitud del vector 
abs_fou.caso3 = 0.5*abs(fourier.caso3) / (l_fou.caso3 / 2); % valor absoluto de la FFT
delta_frec.caso3 = frecsam(3) / l_fou.caso3; %delta de frecuencia 
eje_frec.caso3 = (0:1:l_fou.caso3 - 1)*delta_frec.caso3; %eje de frecuencia

% para fm=10000Hz
fourier.caso4 = fft(y.caso4); % algoritmo fft
l_fou.caso4 = length(fourier.caso4); %longitud del vector 
abs_fou.caso4 = 0.5*abs(fourier.caso4) / (l_fou.caso4 / 2); % valor absoluto de la FFT
delta_frec.caso4 = frecsam(4) / l_fou.caso4; %delta de frecuencia 
eje_frec.caso4 = (0:1:l_fou.caso4 - 1)*delta_frec.caso4; %eje de frecuencia


% se dibujan los resultados
figure;
subplot(2,2,1); 
stem(eje_frec.caso1, abs_fou.caso1);
grid;
title('Señal fm=120 [Hz]');
xlabel('f [Hz]');

subplot(2,2,3);
stem(eje_frec.caso3, abs_fou.caso3);
grid;
title('Señal fm=1000 [Hz]');
xlabel('f [Hz]');

subplot(2,2,2);
stem(eje_frec.caso2, abs_fou.caso2);
grid;
title('Señal fm=600 [Hz]');
xlabel('f [Hz]');

subplot(2,2,4);
stem(eje_frec.caso4, abs_fou.caso4);
grid;
title('Señal fm=10000 [Hz]');
xlabel('f [Hz]');


