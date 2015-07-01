%Establezco dos dimensiones para la ventana y asi poder comparar
% resultados. Establezco n = 40 y m = 80.

% El color azul de la grafica es para el valor de n y el color verde
% para el valor de m.

n = 40, m = 80;

%Ventana Rectangular

wvtool(rectwin(n),rectwin(m)),
pause;

%Ventana Bartlett

wvtool(bartlett(n),bartlett(m)),
pause;

%Ventana Hamming

wvtool(hamming(n),hamming(m)),
pause;

%Ventana Blackman

wvtool(blackman(n),blackman(m)),
pause;