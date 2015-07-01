function y = gensin(amp,frec,fase,lim_i,lim_s)
if (lim_i > lim_s)
    error('El l�mite inferior establecido no puede superar el l�mite superior');
end
nn = lim_i:lim_s; 
%Definimos el vector acotando su principio y fin con los valores
% de lim_i (inferior) y lim_s (superior).
fsin = amp * sin(nn * frec + fase);
%Aplicamos la funcion sinusoidal con los parametros de entrada
y = stem(nn,fsin);
%Devolvemos el resultado de la funci�n como una representacion 
% grafica de la misma.

%amp = amplitud, frec = frecuencia, lim_i = limite inferior
% lim_s = limite superior