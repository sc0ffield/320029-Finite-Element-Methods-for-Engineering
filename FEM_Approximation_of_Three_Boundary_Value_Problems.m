clear
clc
close all

%% Malla T1
malla = [0 0.1 0.5 0.9 1];

N = length(malla);
M = N-2;

%% Funcions f(x)

f1 = @(x) 5;
f2 = @(x) 10;
f3 = @(x) 10*(1-x);

%% Matriu A

A = zeros(M,M);

for i=1:M

    hi   = malla(i+1)-malla(i);
    hip1 = malla(i+2)-malla(i+1);

    A(i,i) = 1/hi + 1/hip1;

    if i<M
        A(i,i+1) = -1/hip1;
    end

    if i>1
        A(i,i-1) = -1/hi;
    end
end

disp('Matriu A')
disp(A)

%% Funcions de forma (hat functions)

phi{1} = @(x) ...
    ((x>=malla(1) & x<=malla(2)).*(x-malla(1))/(malla(2)-malla(1))) + ...
    ((x>=malla(2) & x<=malla(3)).*(malla(3)-x)/(malla(3)-malla(2)));

phi{2} = @(x) ...
    ((x>=malla(2) & x<=malla(3)).*(x-malla(2))/(malla(3)-malla(2))) + ...
    ((x>=malla(3) & x<=malla(4)).*(malla(4)-x)/(malla(4)-malla(3)));

phi{3} = @(x) ...
    ((x>=malla(3) & x<=malla(4)).*(x-malla(3))/(malla(4)-malla(3))) + ...
    ((x>=malla(4) & x<=malla(5)).*(malla(5)-x)/(malla(5)-malla(4)));

%% Condicions de contorn

u0 = 1;
u1 = 0;

%% ==========================================================
%% PROBLEMA 1

b1 = zeros(M,1);

for i=1:M
    b1(i) = integral(@(x) f1(x).*phi{i}(x),0,1);
end

b1(1) = b1(1) + u0/(malla(2)-malla(1));
b1(3) = b1(3) + u1/(malla(5)-malla(4));

xi1 = A\b1;

disp('Coeficients problema 1')
disp(xi1)

%% ==========================================================
%% PROBLEMA 2

b2 = zeros(M,1);

for i=1:M
    b2(i) = integral(@(x) f2(x).*phi{i}(x),0,1);
end

b2(1) = b2(1) + u0/(malla(2)-malla(1));
b2(3) = b2(3) + u1/(malla(5)-malla(4));

xi2 = A\b2;

disp('Coeficients problema 2')
disp(xi2)

%% ==========================================================
%% PROBLEMA 3

b3 = zeros(M,1);

for i=1:M
    b3(i) = integral(@(x) f3(x).*phi{i}(x),0,1);
end

b3(1) = b3(1) + u0/(malla(2)-malla(1));
b3(3) = b3(3) + u1/(malla(5)-malla(4));

xi3 = A\b3;

disp('Coeficients problema 3')
disp(xi3)

%% ==========================================================
%% Construccio de les solucions aproximades

U1 = @(x) xi1(1)*phi{1}(x) + xi1(2)*phi{2}(x) + xi1(3)*phi{3}(x);

U2 = @(x) xi2(1)*phi{1}(x) + xi2(2)*phi{2}(x) + xi2(3)*phi{3}(x);

U3 = @(x) xi3(1)*phi{1}(x) + xi3(2)*phi{2}(x) + xi3(3)*phi{3}(x);

%% ==========================================================
%% ==========================================================
%% Grafiques comparant MEF i solucio exacta

%% Solucions exactes

u1_exacta = @(x) 1 - (5/2)*x.^2;

u2_exacta = @(x) 1 - (5/3)*x.^3;

u3_exacta = @(x) 1 - 5*x.^2 + (5/3)*x.^3;
xplot = linspace(0,1,1000);

figure

%% Problema 1
subplot(3,1,1)

plot(xplot,U1(xplot),'LineWidth',2)
hold on
plot(xplot,u1_exacta(xplot),'--','LineWidth',2)

title('Problema 1')
legend('MEF','Exacta')
grid on

%% Problema 2
subplot(3,1,2)

plot(xplot,U2(xplot),'LineWidth',2)
hold on
plot(xplot,u2_exacta(xplot),'--','LineWidth',2)

title('Problema 2')
legend('MEF','Exacta')
grid on

%% Problema 3
subplot(3,1,3)

plot(xplot,U3(xplot),'LineWidth',2)
hold on
plot(xplot,u3_exacta(xplot),'--','LineWidth',2)

title('Problema 3')
legend('MEF','Exacta')
grid on