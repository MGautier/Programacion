%Creamos el vector impulso unidad de longitud 128.

x = ones(1,128);

%Definimos los vectores de coeficientes obtenidos como resultado
% de las operaciones matematicas anteriores.

a = [1 0.13 0.2 0.3];
b = [0.6 -0.48 0.48 -1.6];

%Aplicamos el filtro sobre el vector impulso para obtener las respuestas
% que se generan.

y = filter(b,a,x);

% Representamos dicho impulso con una grafica.

plot(y)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta del impulso}','FontSize',14)
pause;


% Definimos nuestra region de convergencia para la circunferencia
% en donde podremos obtener si nuestro sistema de analisis es
% causal o no, e inestable o no.

zplane(b,a);
title('Polos y Ceros');
