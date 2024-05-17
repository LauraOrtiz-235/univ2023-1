
%%%%%%%%%% 2.3 Removing Unwanted Tones %%%%%%%%%%
clc;

% Leer el audio corrompido
[x, Fs] = audioread('buzzjc.wav');

% Encontrar la frecuencia de los tonos no deseados con DFT
X = fft(x);
f = linspace(-Fs/2, Fs/2, length(X));

figure;
plot(f, abs(fftshift(X)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Vamos a remover estos tonos, como? Podemos establecer los coeficientes
% correspondientes en la DFT a cero y luego calcular la IDFT para obtener 
% la señal filtrada. 

% Identificar las frecuencias de los tonos no deseados

%X(round(220*length(X)/Fs) + 1) = 0;
%X(round(440*length(X)/Fs) + 1) = 0;
%X(round(660*length(X)/Fs) + 1) = 0;
%X(round(880*length(X)/Fs) + 1) = 0;

frequencies = [220 440 660 880];
bins = round(frequencies/Fs*size(X,1));
bins = unique(bins); 
tones = X(bins);

% remove tone frequencies
X(bins) = 0;

% Establecer los coeficientes correspondientes en la DFT a cero


% Calcular la IDFT para obtener la señal filtrada
x_filtered = real(ifft(X));

% Una vez eliminados los tonos no deseados, podemos escuchar la señal 
% filtrada. Y toca usar la parte real de la señal.

% Escuchar la señal original y la señal filtrada
sound(x, Fs);
pause(5);
sound(x_filtered, Fs);
