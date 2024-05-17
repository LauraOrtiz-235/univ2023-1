
function armonicas_fft

% Se construye el eje de tiempo
k = 4;                  %numero de periodos
w = 377;                %frecuencia fundamental
f = w/(2*pi);           %frecuencia en Hz
fm = 1000*f;            %frecuencia de muestreo
t = 0:1/fm:k*(2*pi)/w;  %eje de tiempo

l = length(t);
factor = l/2;
delta = (fm / (2*factor));           %delta de frecuencias
fre_vec = (0:1:length(t) - 1)*delta; %vector de frecuencias

wo = 377; %frecuencia fundamental
y = 0;
kk = 1;

for ii=1:2:9 % cuatro componentes armónicas
    y = kk*cos(ii*wo*t) + y; %suma de las componentes armónicas 
    kk = kk - 0.2;
end

figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off');
plot(t, y);
xlabel('Tiempo[Sg]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('x (t)', 'fontname', 'verdana', 'fontsize', 8) 
title('Gráfica de la señal x(t)');
gg=gca;
set(gg, 'fontsize', 8);
line([t(1) t(length (t))], [0 0], 'color', [0 0 0], 'linestyle',':');
pause(1);

% Se calcula la FFT y se visualiza el resultado
ftt = fft(y);
figure('color', [202 225 249]/255, 'numbertitle', 'off');
stem(fre_vec(1:31), abs(ftt(1:31))/factor);
grid;
xlabel('Frecuencia [Hz)', 'fontname', 'verdana', 'fontsize', 8);
ylabel('FFT Magnitud', 'fontname', 'verdana', 'fontsize', 8);
title('Gráfica de la Transformada de Fourier de x(t)')


