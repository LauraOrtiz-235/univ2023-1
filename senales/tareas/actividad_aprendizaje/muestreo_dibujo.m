
function muestreo_dibujo

% se establece la frecuencia de muestreo 
frecsam=[120 600 1000 100000];

% contrucción del eje de tiempo
tiempo.caso1=0:1/frecsam (1):1/60; 
tiempo.caso2=0:1/frecsam (2):1/60;
tiempo.caso3=0:1/frecsam (3):1/60; 
tiempo.caso4=0:1/frecsam (4):1/60;

% contrucción del eje de tiempo en muestras
muestras.caso1 = 0:numel(0:1/frecsam(1):1/60)-1; 
muestras.caso2 = 0:numel(0:1/frecsam(2):1/60)-1;
muestras.caso3 = 0:numel(0:1/frecsam(3):1/60)-1; 
muestras.caso4 = 0:numel(0:1/frecsam(4):1/60)-1;

% construcción de la señal
y.caso1=sin(377*tiempo.caso1); 
y.caso2=sin(377*tiempo.caso2); 
y.caso3=sin(377*tiempo.caso3);
y.caso4=sin(377*tiempo.caso4);

% se dibujan los resultados
figure;
subplot(2,2,1); 
stem(tiempo.caso1, y.caso1);
grid;
title('Señal f (t)=sin (377t) con fm=120 [Hz]');
xlabel('Tiempo[sg]');

subplot(2,2,3);
stem(tiempo.caso3, y.caso3); 
grid; 
title('Señal f (t)=sin (377t) con fm=1000 [Hz]'); 
xlabel('Tiempo [sg]'); 

subplot(2,2,2);
stem(tiempo.caso2, y.caso2);
grid;
title('Señal f (t)=sin (377t) con fm=600 [Hz]'); 
xlabel('Tiempo [sg]'); 

subplot(2,2,4);
stem(tiempo.caso4, y.caso4);
grid;
title('Señal f (t)=sin (377t) con fm=100000 [Hz]'); 
xlabel('Tiempo [sg]'); 


figure;
subplot(2,2,1); 
stem(muestras.caso1, y.caso1);
grid;
title('Señal f (t)=sin (377t) con fm=120 [Hz]');
xlabel('Muestras');

subplot(2,2,3);
stem(muestras.caso3, y.caso3); 
grid; 
title('Señal f (t)=sin (377t) con fm=1000 [Hz]'); 
xlabel('Muestras');

subplot(2,2,2);
stem(muestras.caso2, y.caso2);
grid;
title('Señal f (t)=sin (377t) con fm=600 [Hz]'); 
xlabel('Muestras');

subplot(2,2,4);
stem(muestras.caso4, y.caso4);
grid;
title('Señal f (t)=sin (377t) con fm=100000 [Hz]'); 
xlabel('Muestras');





