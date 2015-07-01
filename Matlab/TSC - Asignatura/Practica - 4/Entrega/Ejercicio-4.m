%Establezco una dimension fija para la ventana de Kaiser
% vamos variando su parametro beta segun nos pide el enunciado.

ventana = 31;

%Para Beta 3.

wvtool(kaiser(ventana,3)),
pause;

%Para Beta 5.

wvtool(kaiser(ventana,5)),
pause;

%Para Beta 8.

wvtool(kaiser(ventana,8)),
pause;


