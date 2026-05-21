% Parametres del problema
mu = 1000;
tspan = [0 3000]; % Interval ampli per observar el cicle en sistemes rigids
y0 = [2; 0];

% Definicio del sistema de Van der Pol
vdp_fun = @(t, y) [y(2); mu*(1 - y(1)^2)*y(2) - y(1)];

% Resolucio amb ode23 i mesura de temps
tic;
[t, y] = ode23(vdp_fun, tspan, y0);
temps_execucio = toc;

% Resultats
n_passos = length(t);
fprintf('--- Resultats ode23 (mu = 1000) ---\n');
fprintf('Nombre de passos: %d\n', n_passos);
fprintf('Temps computacional: %.6f segons\n', temps_execucio);

% Grafiques per detectar oscillacions
figure;
subplot(2,1,1);
plot(t, y(:,1), 'b-');
title(['Solucio y(t) amb ode23, \mu = ', num2str(mu)]);
xlabel('t'); ylabel('y(t)');
grid on;

subplot(2,1,2);
plot(y(:,1), y(:,2), 'r-');
title('Pla de fase (Cicle limit)');
xlabel('y'); ylabel('dy/dt');
grid on;