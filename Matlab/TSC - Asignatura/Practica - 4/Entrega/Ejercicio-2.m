%Establezco un tamano de ventana de n = 31 que es lo que
% nos pide el enunciado

ventana = 31;

%Ventana Rectangular

wvtool(rectwin(ventana)),
pause;

%Ventana Bartlett

wvtool(bartlett(ventana)),
pause;

%Ventana Hamming

wvtool(hamming(ventana)),
pause;

%Ventana Blackman

wvtool(blackman(ventana)),
pause;

