
function muestreo_fft

w = 377;
fs = 2000;
t = 0:1/fs:1/60;

y = sin(377*t);

figure;
stem(y);
title(['Grafica de la señal x(t) = sin(' num2str(w), ...
    ' t) y fmuestreo = ' num2str(fs) ' [Hz]']);
xlabel('Muestras de la señal')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
abs_fourier_half = abs(fft(y))/length(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
stem(abs_fourier_half);
%stem(abs(fft(y)));
title(['Grafica de la señal x(t) = sin(' num2str(w), ...
    ' t) y fmuestreo = ' num2str(fs) ' [Hz] usando fft']);
xlabel('Coeficientes')

fft_result = fft(y);

l_fourier = length(fft_result);
abs_fourier = abs(fft_result) / (l_fourier/2); 
delta_f = fs / l_fourier;

eje_f = (0:1:l_fourier - 1)*delta_f;

figure;
stem(eje_f, abs_fourier);
grid;
title(['Señal fmuestreo = ' num2str(fs) ' [Hz]']);
xlabel('Frec [Hz]')


