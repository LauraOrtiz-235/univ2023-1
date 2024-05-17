%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% TALLER 3 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% 2.1 FFT %%%%%%%%%%%%%%%%%%%%
clc;

% Crear una señal de prueba
x = [1 2 3 4 5 6 7 8];

% Realizar la transformada de Fourier
X = fft(x);

% Visualizar el resultado
disp(X);



%%
%%%%%%%%%%% 2.2 Simple vector signals %%%%%%%%%%%
clc;

% Establecer los valores de n, Ω1 y Ω2
n = 64;
Omega1 = 10*(2*pi/n);
Omega2 = 14*(2*pi/n);

% Crear la señal x(k)
k = 0:n-1;
x = cos(Omega1*k) + 0.5*cos(Omega2*k);

% Tomar la DFT de la señal x(k)
X = fft(x);

% Centrar la frecuencia cero en la trama
X_shifted = fftshift(X);

% Crear el vector de frecuencias
frequencies = linspace(-pi,pi,n);

% Graficar la DFT vs frecuencias
plot(frequencies, abs(X_shifted));

% Agregar líneas verticales en las frecuencias ±Ω1 y ±Ω2
line([-Omega2, -Omega2], ylim, 'Color', 'g', 'LineStyle', '--');
line([-Omega1, -Omega1], ylim, 'Color', 'g', 'LineStyle', '--');
line([Omega1, Omega1], ylim, 'Color', 'g', 'LineStyle', '--');
line([Omega2, Omega2], ylim, 'Color', 'g', 'LineStyle', '--');
hold on

title('DFT of x(k)');
xlabel('Frequency');
ylabel('Magnitude');


% PREGUNTAS:

% - Does the plot of the DFT agree with what you expected?

% La señal x(k) es una suma de dos COS con frecuencias Ω1 y Ω2. 
% Esperamos que la DFT de esta señal muestre picos en las dos frecuencias.
% Podemos ver que la gráfica generada por el código muestra picos en las 
% posiciones esperadas. Además, las líneas verticales punteadas trazadas 
% en las frecuencias Ω1 y Ω2 muestran que los picos están en las posiciones
% esperadas.
% Por lo tanto, podemos concluir que la gráfica de la DFT obtenida está de 
% acuerdo con nuestras expectativas teóricas.

