
%%%%%%%%%%%%%%% LAB SISTEMAS CONTROLABLES Y OBSERVABLES %%%%%%%%%%%%%%%

% a).

A = [-2 -6 -4; 1 0 0; 0 1 0];
B = [1; 0; 0];
C = [5 0 2];
D = 0;

% Calculamos la matriz de controlabilidad
Cc = ctrb(A, B);
disp(Cc);

% Calculamos el determinante para saber si es NO singular
fprintf('Determinante = %f\n', det(Cc));


% Calculamos el rango para ver si es igual al número de filas
rango = rank(Cc);
fprintf('Rango = %f\n', rango);

if rango == size(A,1)
    disp("El sistema es controlable")
else
    disp("El sistema no es controlable")
end


sys = ss(A,B,C,D);


% Simulación del sistema
t = 0:0.1:10;
u_step = t>=0;
u_impulse = t==0;
u_ramp = t.*u_step;
u_parabola = t.^2.*u_step;

figure;
subplot(2,2,1)
step(sys)
title("Respuesta a señal de paso")

subplot(2,2,2)
lsim(sys, u_ramp, t)
title("Respuesta a señal de rampa")

subplot(2,2,3)
lsim(sys, u_impulse, t)
title("Respuesta a señal de impulso")

subplot(2,2,4)
lsim(sys, u_parabola, t)
title("Respuesta a señal de parábola")



%% 
% b). 

A = [-1 0; 0 1];
B = [0; 2];
C = [2 0]; 
D = 0;

% Calculamos la matriz de controlabilidad
Cc = ctrb(A, B);
disp(Cc);

% Calculamos el determinante para saber si es NO singular
fprintf('Determinante = %f\n', det(Cc));


% Calculamos el rango para ver si es igual al número de filas
rango = rank(Cc);
fprintf('Rango = %f\n', rango);

if rango == size(A,1)
    disp("El sistema es controlable \n")
else
    disp("El sistema no es controlable \n")
end


sys = ss(A,B,C,D);


% Simulación del sistema
t = 0:0.1:10;
u_step = t>=0;
u_impulse = t==0;
u_ramp = t.*u_step;
u_parabola = t.^2.*u_step;

figure;
subplot(2,2,1)
step(sys)
title("Respuesta a señal de paso")

subplot(2,2,2)
lsim(sys, u_ramp, t)
title("Respuesta a señal de rampa")

subplot(2,2,3)
lsim(sys, u_impulse, t)
title("Respuesta a señal de impulso")

subplot(2,2,4)
lsim(sys, u_parabola, t)
title("Respuesta a señal de parábola")



%% 
% c). 

A = [-1 1 0; 4 0 -2; -5 8 10];
B = [1; 0; -1];
C = [0 0 0];
D = 0;

% Calculamos la matriz de controlabilidad
Cc = ctrb(A, B);
disp(Cc);

% Calculamos el determinante para saber si es NO singular
fprintf('Determinante = %f\n', det(Cc));


% Calculamos el rango para ver si es igual al número de filas
rango = rank(Cc);
fprintf('Rango = %f\n', rango);

if rango == size(A,1)
    disp("El sistema es controlable")
else
    disp("El sistema no es controlable")
end


sys = ss(A,B,C,D);


% Simulación del sistema
t = 0:0.1:10;
u_step = t>=0;
u_impulse = t==0;
u_ramp = t.*u_step;
u_parabola = t.^2.*u_step;

figure;
subplot(2,2,1)
step(sys)
title("Respuesta a señal de paso")

subplot(2,2,2)
lsim(sys, u_ramp, t)
title("Respuesta a señal de rampa")

subplot(2,2,3)
lsim(sys, u_impulse, t)
title("Respuesta a señal de impulso")

subplot(2,2,4)
lsim(sys, u_parabola, t)
title("Respuesta a señal de parábola")






