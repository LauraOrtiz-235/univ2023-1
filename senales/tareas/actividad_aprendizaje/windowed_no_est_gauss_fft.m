
function windowed_no_est_gauss_fft

close all
paso = 0.000001;
t = 0:paso:(2*pi)/377;
ll = length(t);
factorr = ll/2;

% inicaliza valores
wo = 377;
y = []; 

for ii=1:4:9
    y = [y cos(ii*wo*t)];
end

% calculo de la fft de la señal sin ventaneo
tt = length(y); 
factorrr = tt/2;
delta = (1/paso) / (2*factorrr);
tiempo = (0:1:tt-1)*paso; % eje de tiempo 
ftt = fft(y);
n = 0:tt-1;
nn = n*round(delta); % vector de frecuencias 


figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off');
stem(nn(1:40), abs(ftt (1:40)) /factorr);
grid;
xlabel('Frecuencia [Hz]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('FFT Magnitud', 'fontname', 'verdana', 'fontsize', 8);
title('Gráfica de la Transformada de Fourier de y (t)');

% se define una ventana de gauss
x = 0:1:length(y) - 1;
miu = 20000;
sigma = 5000; 
muestras = length(y);
windowgauss = (1)*exp(-0.5*(((x - miu) / sigma).^2)); %construcción Gaussiana 

figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off');
plot(tiempo, y, 'b', tiempo, windowgauss, 'r');
xlabel('Tiempo [Sg]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('y (t)', 'fontname', 'verdana', 'fontsize', 8);
title('Gráfica de la señal y(t)');
gg = gca;
set(gg, 'fontsize', 8);
line([tiempo(1) tiempo(length(tiempo))], [0 0], 'color', [0 0 0], 'linestyle',':');

% se obtiene la señal ventaneada
ymodf = windowgauss.*y; % señal ventaneada 
figure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'ofg');
plot(tiempo, ymodf);
xlabel('Tiempo[Sg]', 'fontname', 'verdana', 'fontsize', 8);
ylabel('y (t)', 'fontname', 'verdana', 'fontsize', 8);
title ('Gráfica de la señal y(t) ventaneada (Windowed)') 
gg = gca;
set(gg, 'fontsize', 8);
line([tiempo(1) tiempo(length(tiempo))], [0 0], 'color', [0 0 0], 'linestyle',':');

ymodffft = fft (ymodf); %FFT de señal ventaneada
fiqure('color', [202 225 249]/255, 'menubar', 'none', 'numbertitle', 'off'); 
stem (nn(1:40), abs(ymodffft(1:40)) / factorr);
grid;
xlabel('Frecuencia [Hz]', 'fontname', 'verdana', 'fontsize', 8);
ylabel ('FFT Magnitud', 'fontname', 'verdana', 'fontsize', 8);
title('Gráfica de la Transformada de Fourier de y(t) ventaneada (Windowed)')

