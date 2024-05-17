%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TALLER 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

% En un teléfono de tonos, hay una frecuencia asociada con cada columna y
% cada fila del teclado. Cuando se presiona un botón, la señal transmitida 
% por la linea telefonica es la suma de dos sinusoides, una con la 
% frecuencia de columna y otra con la frecuencia de fila.

% Este sistema se denomina DTMF. Vamos a tener que las frecuencias de las 
% columnas son: 1209, 1306 y 1477 Hz de izquierda a derecha, con 1633 Hz 
% asociados con una cuarta columna que generalmente no esa. Las frecuencias
% de fila son: 697, 770, 852 y 941 Hz, de arriba a abajo. Cada tono debe 
% tener una duración de al menos 40mseg y el espacio entre tonos de 40mseg.

% Cargar la señal de audio
[y, Fs] = audioread('tel.wav');

% Calcular la Transformada de Fourier de la señal
Y = fft(y);

% Definir el vector de frecuencia correspondiente a la Transformada de Fourier
f = linspace(-Fs/2, Fs/2, length(Y));

% Graficar el espectrograma, esto lo hacemos para ver las frecuencias
% asociadas con la columna y la fila, para asi decodificar el numero

winlen = round(Fs*0.04);     % Longitud de la ventana 
overlap = 200;               % Superposición entre ventanas
nfft = 2^nextpow2(winlen);   % Longitud de la transformada de Fourier

spectrogram(y, [], overlap, nfft, Fs);

% Teniendo en cuenta el espectrograma, y que las frecuencias tenemos que
% verlas de izquierda a derecha, y de arriba a abajo como se indica, 
% podemos ver que son 7 numeros. Los cuales son:

% El primer tono genera el numero 9.
% El segundo genera el numero 0.
% El tercero el numero 3.
% El cuarto el numero 5.
% El quinto el numero 7.
% El sexto el numero 6.
% Y el ultimo tono el numero 8.

% Por lo tanto el numero marcado fue 9035768


