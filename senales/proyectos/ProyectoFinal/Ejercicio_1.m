%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio Propuesto 1 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Diferentes tiempos
s = 1;

% cte de la ecuacion diferencial
A = 0.2;
B = 0.0001;
a = 1/(A*B);
b = 1/B;

K = 100;

%extraemos los resultados de la simulacion
load_system("Punto1_Simulink.slx");
sim("Punto1_Simulink.slx");

x = get(ans.simOut, 'Data');
t = get(ans.simOut, 'Time');
sig_len = length(x);

% hacemos la linea del 63.2% de la señal
signal_carac = max(x)*(0.632);
xcarac = ones(1, sig_len).*signal_carac;

% Buscamos el tiempo caracteristico es decir el índice del punto 
% en el que la señal cruza el 63.2% de su valor final
idx_carac = find(x >= signal_carac, 1);

% Obtén el tiempo característico
tiempo_carac = t(idx_carac);


% Plot de la señal con su tiempo caract
plottlt = sprintf("Señal para A = %d, B = %d, K = %d, tcaract = %.2f", A, B, K, tiempo_carac);

hold on 

plot(t, x);
plot(t, xcarac);
stem(tiempo_carac, signal_carac);
title(plottlt);

legend(["Señal original", "63.2 % de la señal", "punto de tiempo caracteristico"]);

hold off 

% Guardar el plot con el formato de nombre de archivo especificado
nombre_archivo = sprintf("/home/laura/Pictures/DAVIDPUTADEMRDA/tiempocaract_A:%d_B:%d_K:%d_t:%.2f.png", A, B, K, tiempo_carac);
saveas(gcf, nombre_archivo);
