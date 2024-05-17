%%%%%%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%%%%%

clc;

% Elegir wn tal que la frecuencia de -3dB sea 600Hz 
wn = 2*pi*600; 

% Elegir ζ tal que no haya resonancia 
zeta = 1/sqrt(2); 

% Calcular los coeficientes de la función de transferencia para el filtro
% de paso bajo de segundo orden
a = [2*zeta*wn, wn^2];
b = wn^2;

% Frecuencias para el trazado de la curva de Bode
w = logspace(2, 5, 200);

% Respuesta en frecuencia
s = 1i*w;
H = b./(s.^2 + a(1)*s + a(2));

mag = 20*log10(abs(H));
phase = angle(H)*180/pi;

% Diagrama de Bode de la respuesta del filtro, con una frecuencia que va 
% desde 100 Hz a 10 000 Hz.
figure;
subplot(2, 1, 1);
semilogx(w/(2*pi), mag);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Bode Plot of Second-Order Low Pass Filter');

subplot(2, 1, 2);
semilogx(w, phase);
grid on;
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');


% Leer whkight.wav
[y, Fs] = audioread('whknight.wav');

% Vector de tiempo
t = linspace(0, length(y)/Fs, length(y));

% Reproducir la señal sin filtrar
sound(y, Fs);
pause(5);


% Filtramos la señal reconstruida utilizando el circuito Sallen-Key
num = b;
den = [1, a(1), a(2)];

sys = tf(num, den);

y_filtered = lsim(sys, y, t);

% Trazamos la señal reconstruida y filtrada
figure;
subplot(2,1,1);
plot(t, y);
title('Reconstructed Signal');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, y_filtered);
title('Filtered Signal');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');

% Y ahora reproducimos la señal filtrada
sound(y_filtered, Fs);
pause(5);

% Graficar el espectograma para ver la diferencia entre la señal 
% reconstruida y la filtrada
figure;
subplot(2,1,1);
spectrogram(y, 64, 32, 64, Fs);

subplot(2,1,2);
spectrogram(y_filtered, 64, 32, 64, Fs);



%%
%%%%%%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%%%%%

clc;

wn = 2*pi*600; 
zeta = 1/sqrt(2); 

a = [2*zeta*wn, wn^2];
b = wn^2;

[y, Fs] = audioread('whknight.wav');
t = linspace(0, length(y)/Fs, length(y));

num = b;
den = [1, a(1), a(2)];

sys = tf(num, den);
   
% Leer el archivo de sonido "sines.wav" y extraer la señal de audio.
[sines, Fs] = audioread('sines.wav');

% Cuantificar la señal utilizando 8 bits.
sines_quant = round(sines*127)/127;

% Reconstruir la señal cuantificada.
sines_recon = filter([1 -0.95], 1, sines_quant);

% Sumar la señal reconstruida con la señal de voz.
y_noise = y + sines_recon;

% Reproducir la señal sin filtrar
sound(y_noise, Fs);
pause(5);


% Aplicar el filtro diseñado anteriormente a la señal resultante.
y_filtered_noise = lsim(sys, y_noise, t);

% Reproducir la señal filtrada
sound(y_filtered_noise, Fs);
pause(5);


%%
clc;

wn = 2*pi*600; 
zeta = 1/sqrt(2); 

a = [2*zeta*wn, wn^2];
b = wn^2;

w = logspace(2, 5, 200);

[y, Fs] = audioread('whknight.wav');
t = linspace(0, length(y)/Fs, length(y));

num = b;
den = [1, a(1), a(2)];

sys = tf(num, den);

% Leer el archivo de sonido "hfnoise.wav." y extraer la señal de audio.
[hfnoise, Fs] = audioread('hfnoise.wav');

% Cuantificar la señal utilizando 8 bits.
hf_quant = round(hfnoise*127)/127;

% Reconstruir la señal cuantificada.
hf_recon = filter([1 -0.95], 1, hf_quant);

% Sumar la señal reconstruida con la señal de voz.
y_hfnoise = y + hf_recon;

% Reproducir la señal sin filtrar
sound(y_hfnoise, Fs);
pause(5);


% Aplicar el filtro diseñado anteriormente a la señal resultante.
y_filtered_hfnoise = lsim(sys, y_hfnoise, t);

% Reproducir la señal filtrada
sound(y_filtered_hfnoise, Fs);
pause(5);

