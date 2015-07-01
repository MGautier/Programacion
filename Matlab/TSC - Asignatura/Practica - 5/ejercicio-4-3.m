% Se nos pide representar la grafica modulo y fase con 512 muestras
% de frecuencia alrededor de toda la circunferencia unidad.

a = [1 0.13 0.2 0.3];
b = [0.6 -0.48 0.48 -1.6];


[h,w] = freqz(b,a,512,'whole');
figure(1)
plot(w/pi,abs(h));title('Respuesta en frecuencias (circulo unidad)')
xlabel('Frecuencia')
ylabel('Modulo')
figure(2)
plot(w/pi,angle(h));title('Respuesta en frecuencias (circulo unidad)')
xlabel('Frecuencia')
ylabel('Fase')
pause;

% Ahora para representar unicamente la mitad superior de la circunferencia
% de radio unidad.

[h,w] = freqz(b,a,512);
figure(1)
plot(w/pi,abs(h));title('Respuesta en frecuencias (mitad superior)')
xlabel('Frecuencia')
ylabel('Modulo')
figure(2)
plot(w/pi,angle(h));title('Respuesta en frecuencias (mitad superior)')
xlabel('Frecuencia')
ylabel('Fase');
