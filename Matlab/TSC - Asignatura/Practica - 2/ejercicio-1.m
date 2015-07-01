coeficientes = [-1/4,1/2,1/2,1/2,-1/4];
x = -2:2;

%Ahora nos centramos en representar el espectro en magnitud y fase

subplot(211);
stem(x,abs(coeficientes));
title('Espectro en magnitud');
xlabel = ('Frecuencia');

subplot(212);
stem(x,angle(coeficientes));
title('Espectro en fase');
xlabel = ('Frecuencia');

