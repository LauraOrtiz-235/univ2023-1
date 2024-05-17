%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Parcial 3 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PUNTO 2
% Matrices de Estado
A = [2 -7 4; 1 0 0 ; 0 1 0];
B = [1; 0; 0];
C = [0 1 2];
D = 0;


% El sistema no es estable
disp(eig(A));
sys = ss(A,B,C,D);
disp(isstable(sys));


% Determinar los valores de la matriz K para que el sistema sea estable
k = place(A, B, [-2 - 2i*sqrt(3), -2 + 2i*sqrt(3), -10]);
fprintf('Valores para K = %f\n', k);



% PUNTO 3

A2 = [0 0 1 0; 0 0 0 1; -4 2 -1 1; 2 -2 1 -1];
B2 = [0; 0; 2; 0];
C2 = [1 0 0 0; 0 0 1 0];
D2 = 0;

syms s

y(s) = s + 2;


