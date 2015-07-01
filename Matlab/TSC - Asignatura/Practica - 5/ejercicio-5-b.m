% Calculamos los polos y los ceros de la funcion de transferencia
% aplicando la funcion tf2zp a los coeficientes proporcionados 
% anteriormente.

[z,p,k] = tf2zp(b,a);

% Definimos nuestra region de convergencia para la circunferencia
% en donde podremos obtener si nuestro sistema de analisis es
% causal o no, e inestable o no.

zplane(b,a);
title('Polos y Ceros');
