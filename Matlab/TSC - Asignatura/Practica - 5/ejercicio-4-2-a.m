%Definimos la funcion escalon y la representamos para una amplitud de
% valor 3.

x = zeros(1,250);
t = -49:200;
x (50:250) = 3;
stem(t,x) ;
title('Funcion escalon');


a = [1 0.13 0.2 0.3];
b = [0.6 -0.48 0.48 -1.6];

% Filtramos los vectores anteriores de coeficientes junto a la nueva
% funcion escalon obtenido previamente. Asi podemos obtener la respuesta
% de dicho impluso y hallar la respuesta en regimen permanente.

y = filter(b,a,x);
plot(y)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta al escalon}','FontSize',14)
