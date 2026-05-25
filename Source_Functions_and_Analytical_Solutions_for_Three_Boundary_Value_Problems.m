%% Problema 1

x = linspace(0,1,1000);

f = 5*ones(size(x));
u = 1 - (5/2)*x.^2;

figure;
plot(x,f,'LineWidth',2);
hold on;
plot(x,u,'LineWidth',2);

grid on;
xlabel('x');
ylabel('Valor');
title('Problema 1');
legend('f(x)=5','u(x)=1-(5/2)x^2');


%% Problema 2

x = linspace(0,1,1000);

f = 10*x;
u = 1 - (5/3)*x.^3;

figure;
plot(x,f,'LineWidth',2);
hold on;
plot(x,u,'LineWidth',2);

grid on;
xlabel('x');
ylabel('Valor');
title('Problema 2');
legend('f(x)=10x','u(x)=1-(5/3)x^3');


%% Problema 3

x = linspace(0,1,1000);

f = 10*(1-x);
u = 1 - 5*x.^2 + (5/3)*x.^3;

figure;
plot(x,f,'LineWidth',2);
hold on;
plot(x,u,'LineWidth',2);

grid on;
xlabel('x');
ylabel('Valor');
title('Problema 3');
legend('f(x)=10(1-x)', ...
    'u(x)=1-5x^2+(5/3)x^3');