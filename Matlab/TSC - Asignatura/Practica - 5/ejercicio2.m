%Definimos la funcion escalon y la representamos para una amplitud de
% valor 3.

x = zeros(1,250);
t = -49:200;
x (50:250) = 3;
stem(t,x) ;
title('Funcion escalon')
pause;

% Filtramos los vectores anteriores de coeficientes junto a la nueva
% funcion escalon obtenido previamente. Asi podemos obtener la respuesta
% de dicho impluso y hallar la respuesta en regimen permanente.

y = filter(b,a,x);
plot(y)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta al escalon}','FontSize',14)
pause;

% Se nos pide que calculemos la respuesta transitoria de la respuesta
% total de la signal anterior.

% rgp = respuesta en regimen permanente
% rt = respuesta transitoria

rgp = 1.895;
rt = y - rgp;
plot(rt)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta transitoria obtenida del escalon}','FontSize',14)
pause;

% Ahora representaremos la respuesta transitoria en el intervalo
% 0 <= n <= 50

plot(t(50:100),rt(50:100))
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta transitoria}','FontSize',14)
