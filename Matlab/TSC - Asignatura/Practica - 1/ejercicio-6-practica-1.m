nn = 0:25;
X = 3*sin(nn*pi/7) + j*4*cos(nn*pi/7);
%Defino la funcion del enunciado sobre cada elemento del vector nn
figure(1);
subplot(211);
stem(nn,real(X));
title('Parte Real');
xlabel = ('Indice(n)');

subplot(212);
stem(nn,imag(X));
title('Parte Imaginaria');
xlabel = ('Indice(n)');

figure(2)
stem(imag(X),real(X));
title('Parte real en funcion de la parte imaginaria');

%La función subplot permite subdividir una ventana de figura en varias 
%celdas, de modo que es posible realizar una representación gráfica 
%distinta en cada una de ellas.