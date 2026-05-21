clc
clear
close all

% Parametre
mu = 5;

% Interval temporal
tspan = [0 50];

% Condicions inicials
y0 = [2 0];

% Diferents passos d'integracio
hvals = [0.5 0.1 0.05 0.01];

% Vector per guardar temps computacional
temps = zeros(length(hvals),1);

% =========================================================
% GRAFIQUES y(t)
% =========================================================

figure

for k = 1:length(hvals)

    h = hvals(k);

    % Mesura del temps computacional
    tic
    [t,y] = rk4sys(@(t,y) vanderpol(t,y,mu), tspan, y0, h);
    temps(k) = toc;

    subplot(2,2,k)

    plot(t,y(:,1),'LineWidth',1.5)

    grid on

    title(['y(t), h = ', num2str(h)])

    xlabel('t')
    ylabel('y(t)')

end

% =========================================================
% PLA DE FASE
% =========================================================

figure

for k = 1:length(hvals)

    h = hvals(k);

    [t,y] = rk4sys(@(t,y) vanderpol(t,y,mu), tspan, y0, h);

    subplot(2,2,k)

    plot(y(:,1),y(:,2),'LineWidth',1.5)

    grid on

    title(['Pla de fase, h = ', num2str(h)])

    xlabel('y')
    ylabel('dy/dt')

end

% =========================================================
% TAULA TEMPS COMPUTACIONAL
% =========================================================

fprintf('-------------------------------------------\n');
fprintf(' Pas h \t\t Temps computacional (s)\n');
fprintf('-------------------------------------------\n');

for k = 1:length(hvals)
    fprintf('%0.4f \t\t %0.6f\n', hvals(k), temps(k));
end

% =========================================================
% GRAFICA COST COMPUTACIONAL
% =========================================================

figure
plot(hvals,temps,'o-','LineWidth',1.5)
grid on
xlabel('Pas d''integracio h')
ylabel('Temps computacional (s)')
title('Cost computacional en funcio del pas h')

% =========================================================
% FUNCIO VAN DER POL
% =========================================================

function dy = vanderpol(t,y,mu)

dy = zeros(2,1);

dy(1) = y(2);

dy(2) = mu*(1-y(1)^2)*y(2) - y(1);

end

% =========================================================
% FUNCIO RK4SYS
% =========================================================

function [t,yp] = rk4sys(dydt,tspan,y0,h)

if nargin<4
    error('at least 4 input arguments required')
end

if any(diff(tspan)<=0)
    error('tspan not ascending order')
end

n = length(tspan);

ti = tspan(1);
tf = tspan(n);

if n == 2

    t = (ti:h:tf)';

    n = length(t);

    if t(n)<tf

        t(n+1) = tf;

        n = n+1;

    end

else

    t = tspan;

end

tt = ti;

y(1,:) = y0;

np = 1;

tp(np) = tt;

yp(np,:) = y(1,:);

i = 1;

while(1)

    tend = t(np+1);

    hh = t(np+1) - t(np);

    if hh>h
        hh = h;
    end

    while(1)

        if tt+hh>tend
            hh = tend-tt;
        end

        k1 = dydt(tt,y(i,:))';

        ymid = y(i,:) + k1.*hh./2;

        k2 = dydt(tt+hh/2,ymid)';

        ymid = y(i,:) + k2*hh/2;

        k3 = dydt(tt+hh/2,ymid)';

        yend = y(i,:) + k3*hh;

        k4 = dydt(tt+hh,yend)';

        phi = (k1+2*(k2+k3)+k4)/6;

        y(i+1,:) = y(i,:) + phi*hh;

        tt = tt+hh;

        i = i+1;

        if tt>=tend
            break
        end

    end

    np = np+1;

    tp(np) = tt;

    yp(np,:) = y(i,:);

    if tt>=tf
        break
    end

end

end