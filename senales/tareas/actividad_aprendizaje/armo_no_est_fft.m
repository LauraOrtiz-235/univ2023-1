
function armo_no_est_fft

close all     % cierra todas las ventanas abiertasi

fm = 1000000;            % frecuencia de muestreo 
t = 0:(1/fm):(2*pi)/377; % eje de tiempo 
ll = length(t);
factorr = ll/2;

wo = 377; % frecuencias fundamental
y = [];

for ii=1:4:9 %3 componentes armónicas
    y = [y cos(ii*wo*t)]; %una señal seguida de otra
end 

tt = length(y);
factorrr = tt/2;
delta = (1/(1/fm)) / (2*factorrr); %delta de frecuencias en Hz
tiempo = (0:1:tt-1) * (1/fm);      %eje de tiempo

ftt = fft (y);       % calculo de la fft de Matlab 
n = 0:tt-1;
nn = n*round(delta); % eje de frecuencias en Hzi


% Visualización de la señal en el tiempo 
figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off');
plot(tiempo, y);
xlabel('Tiempo[Sg]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('y (t)', 'fontname', 'verdana', 'fontsize', 8) 
title('Gráfica de la señal y(t)')
gg = gca; 
set(gg, 'fontsize', 8);
line([tiempo(1) tiempo(length(tiempo))], [0 0], 'color', [0 0 0], 'linestyle',':')


% Visualización de componentes
figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off');
stem(nn(1:40), abs(ftt(1:40)) / factorr);
grid;
xlabel('Frecuencia [Hz]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('FFT Magnitud', 'fontname', 'verdana', 'fontsize', 8);




