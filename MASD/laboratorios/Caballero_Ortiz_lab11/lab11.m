
% MATRICES DE ESTADO
A = [0 1 0 0; 19.6 0 0 0; 0 0 0 1; -9.8 0 0 0];
B = [0; -1; 0; 1];
C = [1 0 0 0; 0 0 1 0];
D = 0;


% No es estable porque hay una raiz positiva a la izquierda.
eigen_A = eig(A);
disp(eigen_A);


% Determinar Observabilidad
O = obsv(A,C);
disp(O);

rango = rank(O);
fprintf('Rango = %f\n', rango);

if rango == size(A,1)
    disp("El sistema es observable")
else
    disp("El sistema no es observable")
end


% Determinar los valores de la matriz K para que el sistema sea estable
k = place(A,B, [-0.5, -1, -1.5, -2]);
fprintf('Valores para K = %f\n', k);








