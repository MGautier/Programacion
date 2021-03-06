%Creamos el vector impulso unidad de longitud 100.

x = ones(1,100);

%Definimos los vectores de coeficientes obtenidos como resultado
% de las operaciones matematicas anteriores.

a = [1 -0.8741 0.9217 0.26732]; 
b= [0.1866 0.23360 0.23360 0.1866];

%Aplicamos el filtro sobre el vector impulso para obtener las respuestas
% que se generan.

y = filter(b,a,x);

% Representamos dicho impulso con una grafica.

plot(y);
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta del impulso}','FontSize',14)
pause;

expansion = zeros(1,100);
expansion(1) = fracciones(0)+0.698;
for i=1:99
    expansion(i+1) = fracciones(i);
end

plot(expansion)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta del impulso con expansion}','FontSize',14);
