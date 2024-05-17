
% Calcular la FFT diezmada de la señal
function X = fft_diezmado(y)

N = length(y);   % Longitud de la señal
X = zeros(1, N); % Matriz para almacenar los resultados de la FFT diezmada

% Iterar sobre cada columna de la señal
for i = 1:size(y, 2)
    % Iterar sobre cada índice de frecuencia 
    for k = 0:(N-1)
        % Calcular el valor de la FFT diezmada para la frecuencia k 
        X(k + 1, i) = par_impar(k, y(:,i), 'odd') + (exp(-1i*2*pi/N)^k)*par_impar(k, y(:,i), 'even');
    end
end


% Funcion para dividir la secuencia de entrada en dos secuencias de 
% longitud N/2 cada una, correspondientes a las partes par e impar 
function x = par_impar(k, y, part)

N = length(y); % Longitud de la señal
x = 0;         

% Verificar si se debe procesar la parte par o impar de la señal
if strcmp(part, 'even')
    % Índices de muestreo para la parte par 
    n_vals = 0:(floor(N/2) - 1); 
    % Valores de la señal de los índices de muestreo pares
    y_vals = y(2*n_vals + 2);    

else
    % Índices de muestreo para la parte impar
    n_vals = 0:floor(N/2);    
    % Valores de la señal de los índices de muestreo impares
    y_vals = y(2*n_vals + 1); 
end

% Iterar sobre cada índice de muestreo para la parte par o impar 
for n = n_vals
    % Calcular el valor de la FFT diezmada para la frecuencia k 
    x = x + y_vals(n+1)*exp(-1i*2*pi/(N/2))^(n*k);
end


