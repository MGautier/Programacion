function y = Fourier(n,f)

%n muestras para emplear en nuestra transformada.
%f, frecuencia de muestro de cada muestra.

y = fix(fft(n));

dim = length(y);

%length busca el numero de elementos a lo largo de la dimension
% mas grande de una matriz.

%Ordenamos los coeficientes (0 como valor central).
m = floor(dim/2);

%floor nos permite asignar el entero mas proximo 
% o menor, al valor tomado
% como parametro de entrada.

y2=[y(m+2:dim);y(1:m+1)];

%Cambiamos la dimension de la matriz para que 
% en la representacion sea simetrica.

if(mod(dim,2) == 0)
    y2 = y2(1:dim-1);
    dim = dim - 1;
end

%mod devuelve el resto de la division entre sus dos
% operandos.

x = (-floor(dim/2):floor(dim/2))*(f/dim);

%Ahora nos centramos en representar el espectro en magnitud y fase

subplot(211)
stem(x,abs(y2));
title('Espectro en magnitud');
xlabel = ('Frecuencia');

subplot(212);
stem(x,angle(y2));
title('Espectro en fase'); 
xlabel = ('Frecuencia');