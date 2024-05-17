%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% TALLER 2 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%%%%%

clc;

% Parámetros del filtro paso bajo ideal
B = 1;

% Frecuencias para el trazado de la curva de Bode
w = logspace(-1, 2, 200);

% Respuesta en frecuencia del filtro ideal
H = 1./(1 + 1i*w*B);

mag = 20*log10(abs(H));
phase = angle(H)*180/pi;

% Grafica de Bode de la respuesta del filtro
figure;
subplot(2,1,1);
semilogx(w,mag);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Bode plot of ideal low pass filter');

subplot(2,1,2);
semilogx(w,phase);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');


%%
clc;

% Parámetros del filtro paso alto ideal
B = 1;

% Frecuencias para el trazado de la curva de Bode
w = logspace(-1, 2, 200);

% Respuesta en frecuencia del filtro ideal
H = 1i*w/B./(1 + 1i*w*B);

mag = 20*log10(abs(H));
phase = angle(H)*180/pi;

% Grafica de Bode de la respuesta del filtro
figure;
subplot(2,1,1);
semilogx(w,mag);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Bode plot of ideal high pass filter');

subplot(2,1,2);
semilogx(w,phase);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');



%%
%%%%%%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%%%%%

clc;

% Parámetros del circuito RC
R = 1; % Valor de la resistencia en ohmios
C = 1; % Valor del capacitor en faradios

% Frecuencias para el trazado de la curva de Bode
w = logspace(-1, 2, 200);   

% Respuesta en frecuencia del circuito RC
H = 1./(1 + 1i*R*C*w);

mag = 20*log10(abs(H));
phase = angle(H)*180/pi;

% Diagrama de Bode del circuito RC
figure;
subplot(2,1,1);
semilogx(w, mag);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Bode plot of RC circuit in Figure 1');

subplot(2,1,2);
semilogx(w, phase);
grid on;
ylabel('Phase (deg)');
xlabel('Frequency (rad/s)');



%% 
%%%%%%%%%%%%%%%%% PUNTO 3 %%%%%%%%%%%%%%%%%

clc;

% Parámetros del circuito RC
R = 1;      % Valor de la resistencia en ohmios
C = 1;      % Valor del capacitor en faradios

% Frecuencias para el trazado de la curva de Bode
w = logspace(-1, 2, 200);

% Respuesta en frecuencia del circuito RC
H = 1i*w*R*C./(1 + 1i*w*R*C);

mag = 20*log10(abs(H));
phase = angle(H)*180/pi;

% Diagrama de Bode del circuito RC
figure;
subplot(2,1,1);
semilogx(w,mag);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Bode plot of RC circuit in Figure 3');

subplot(2,1,2);
semilogx(w,phase);
grid on;
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');


% PREGUNTAS:

% Para la Figura 3, el circuito es un filtro paso alto de primer orden con 
% una constante de tiempo RC = 1. 

% La pendiente de la curva de ganancia en la banda de atenuación se puede 
% aprox. a -20 dB/dec. Ya que los filtros de primer orden tienen una caída 
% de ganancia de 20 dB por década en la banda de atenuación.



%%
%%%%%%%%%%%%%%%%% PUNTO 4 %%%%%%%%%%%%%%%%%

clc;

% Respuesta en frecuencia para el circuito en cascada
H_lp = 1./(1 + 1i*w*0.01);
H_hp = 1i*w*0.1./(1i*w*0.1 + 1);
H_cascade = H_lp .* H_hp;
%H_cascade = H_hp .* H_lp;

% Frecuencias para el trazado de la curva de Bode
w = logspace(-2, 6, 200);

mag = 20*log10(abs(H_cascade));
phase = angle(H_cascade)*180/pi;

figure;
subplot(2,1,1);
semilogx(w, mag);
title('Bode Plot of Cascaded System');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
grid on;

subplot(2,1,2);
semilogx(w, phase);
xlabel('Frequency (rad/s)');
ylabel('Phase (degrees)');
grid on;


% PREGUNTAS:

% El filtro resultante de la combinación en cascada de los circuitos de la 
% figura 1 y 3 es un filtro de paso de banda. 

% La banda de paso es de aproximadamente de 90 rad/s. Es el resultado de
% restar la frecuencia maxima de corte = 100 rad/s con la frecuencia minima
% de corte = 10 rad/s.

% Sí, el orden de los dos circuitos importa. Si se cambia el orden de los 
% dos circuitos, la respuesta en frecuencia del filtro combinado será 
% diferente. En este caso, la respuesta en frecuencia del filtro combinado 
% sería la del filtro de la Figura 3 seguido por la del filtro de la 
% Figura 1. En general, el orden en que se combinan los filtros puede 
% cambiar la forma de la respuesta en frecuencia del filtro combinado.



%%
%%%%%%%%%%%%%%%%% PUNTO 5 %%%%%%%%%%%%%%%%%

clc;

% Frecuencias para el trazado de la curva de Bode
w = logspace(-1, 2, 200);

% Respuesta en frecuencia del circuito RC
H = 1./(1*(1i*w).^2 + 0.7654*(1i*w) + 1);

mag = 20*log10(H); 
phase = angle(H) * 180/pi; 

% Diagrama de Bode del circuito RC
figure;
subplot(2,1,1);
semilogx(w, mag);
title('Bode Diagram for Sallen-Key Filter');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
grid on;

subplot(2,1,2);
semilogx(w, phase);
ylabel('Phase (deg)');
xlabel('Frequency (rad/s)');
grid on;


% PREGUNTAS:

% Es un filtro de paso bajo, de segundo orden.

% La banda de paso es de aproximadamente de 1.39 rad/s.

% En general, una pendiente de -20 dB/dec indica un filtro de primer orden,
% -40 dB/dec indica un filtro de segundo orden, y así sucesivamente. En 
% este caso para el filtro de Sallen-Key la pendiente de la curva de 
% ganancia en la banda de atenuación se puede aproximar a -40 dB/dec.

% El filtro de Sallen-Key en la figura 2 es un filtro de segundo orden, 
% mientras que el filtro en el punto 1 es de primer orden. El filtro de 
% Sallen-Key también puede tener una pendiente de corte más empinada en la 
% banda de parada en comparación con el filtro de primer orden.

