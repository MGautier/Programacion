[x1,y1] = muestreo(4,5,3,-5,5,0.5);
close(1);
%Con la funcion close cierro la ventana emergente de la figura
% que se muestra en la funcion muestreo y solo dejo
% la que nos da como resultado en el calculo de Fourier
Fourier(x1,0.5);
pause
[x2,y2] = muestreo(4,5,3,-5,5,1.25);
close(1);
Fourier(x2,1.25);
pause
[x3,y3] = muestreo(4,5,3,-5,5,3);
close(1);
Fourier(x3,3);

