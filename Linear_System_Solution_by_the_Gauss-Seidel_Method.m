clc;
clear;
close all;

% Matriu A
A = [4 1 1 0 0;
     2 3 1 1 0;
     1 1 3 1 1;
     0 1 1 4 1;
     0 0 1 1 3];

% Vector b
b = [6; 7; 7; 7; 5];

% Nombre d'iteracions
N = 10;

% Dimensions
n = length(b);

% Llavor inicial
x = zeros(n,1);

% Solucio exacta
x_exacta = A\b;

% Guardar iterats
X = zeros(n,N+1);
X(:,1) = x;

% Vector d'errors
error_real = zeros(1,N+1);

% Error inicial (norma infinit)
error_real(1) = norm(x - x_exacta, inf);

% Descomposicio de Gauss-Seidel
D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);

% Metode de Gauss-Seidel
for k = 1:N

    x = (D + L) \ (b - U*x);

    X(:,k+1) = x;

    % Error real amb norma infinit
    error_real(k+1) = norm(x - x_exacta, inf);

end

% Vector d'iteracions
iter = 0:N;

%% Grafica dels iterats
figure;

plot(iter, X(1,:), 'LineWidth', 1.5);
hold on;
plot(iter, X(2,:), 'LineWidth', 1.5);
plot(iter, X(3,:), 'LineWidth', 1.5);
plot(iter, X(4,:), 'LineWidth', 1.5);
plot(iter, X(5,:), 'LineWidth', 1.5);

grid on;

xlabel('Iteracio');
ylabel('Valor de les incognites');

title('Evolucio dels iterats - Metode de Gauss-Seidel');

legend('x_1','x_2','x_3','x_4','x_5');

%% Grafica de l'error
figure;

semilogy(iter, error_real, 'LineWidth', 1.5);

grid on;

xlabel('Iteracio');
ylabel('Error');

title('Error real del metode de Gauss-Seidel');

legend('||x^{(k)} - x^*||_\infty');