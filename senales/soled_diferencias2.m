
function soled_diferencias2(K_values, A_values, B_values, T, N)

num_cases = numel(K_values);  % Número de casos a evaluar

% Matrices para almacenar las respuestas
Y = zeros(num_cases, N+1);
X = ones(num_cases, N+1);

% Ajuste por recursividad para cada caso
for case_idx = 1:num_cases
    K = K_values(case_idx);
    A = A_values(case_idx);
    B = B_values(case_idx);
    
    for cont = 1:N
        Y(case_idx, cont+1) = (1 - ((1 / (A*B)) * T))*Y(case_idx, cont) + (T/B)*X(case_idx, cont+1);
    end
end

% Dibujar las respuestas en un solo gráfico
figure;
hold on;

for case_idx = 1:num_cases
    stem(0:N, Y(case_idx, :), 'DisplayName', ['K=', num2str(K_values(case_idx)), ', A=', num2str(A_values(case_idx)), ', B=', num2str(B_values(case_idx))]);
end

hold off;
legend;
xlabel('n');
ylabel('y[n]');
title('Respuestas para diferentes valores de K, A y B');
grid on;

end




