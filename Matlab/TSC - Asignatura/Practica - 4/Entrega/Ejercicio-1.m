%Establezco un tamano de ventana de n = 40

ventana = 40;

%Ventana Rectangular

wvtool(rectwin(ventana))
pause;

%Ventana Bartlett

wvtool(bartlett(ventana))
pause;

%Ventana Hamming

wvtool(hamming(ventana))
pause;

%Ventana Hanning

wvtool(hanning(ventana))
pause;

%Ventana Blackman

wvtool(blackman(ventana))
pause;

%Ventana Kaiser
%Establezco el valor de beta a 5 para este tipo de ventana

wvtool(kaiser(ventana,5))
pause;
