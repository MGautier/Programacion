function [x,y] = muestreo(a,t,f,inicio,fin,fm)

if(fin <= inicio)
    error('El fin del intervalo debe ser mayor que el inicio');
end

if(t<=0)
    error('El periodo debe ser positivo');
end

y = inicio:1/fm:fin-1/fm;
x = a * cos(2 * pi * y/t + f);
x = x(:);

figure(1)
stem(y,x);

figure(2);
plot(y,x);