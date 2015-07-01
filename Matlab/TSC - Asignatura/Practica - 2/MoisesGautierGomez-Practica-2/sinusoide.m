function [x,y] = sinusoide(a,t,f,inicio,fin)

if(fin <= inicio)
    error('El fin del intervalo debe ser mayor que el inicio');
end
if(t<=0)
    error ('El periodo debe ser positivo');
end

y = inicio:fin;

x = a*cos(2*pi*y/t + f);

figure(1);
stem(y,x);

figure(2);
plot(y,x);