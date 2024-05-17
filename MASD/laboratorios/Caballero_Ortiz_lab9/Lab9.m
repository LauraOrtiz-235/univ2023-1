
num = [0 5 0 2];
den = [1 2 6 4];
[A,B,C,D] = tf2ss(num,den);

A
B
C
D


%% Representacion en espacio de estado %%

% x1_dot = -2x1 - 6x2 - 4x3 + u
% x2_dot = x1
% x3_dot = x2
% y = 5x1 + 2x3