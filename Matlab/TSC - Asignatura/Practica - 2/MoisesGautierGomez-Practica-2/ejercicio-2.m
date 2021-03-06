coeficientes = ones(11,1)*25/(2*pi);
x = -5:5;

%Ahora nos centramos en representar el espectro en magnitud y fase

subplot(211)
stem(x,abs(coeficientes));
title('Espectro en magnitud');
xlabel = ('Frecuencia');

subplot(212);
stem(x,angle(coeficientes));
title('Espectro en fase'); 
xlabel = ('Frecuencia');