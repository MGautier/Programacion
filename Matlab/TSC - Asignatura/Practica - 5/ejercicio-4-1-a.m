% Como calcular las raices es bastante complicado, utitilizaremos
% directamente la funcion residuez para hallar la descomposicion
% de los vectores de coeficientes.

a = [1 0.13 0.2 0.3];
b = [0.6 -0.48 0.48 -1.6];
[r,p,k] = residuez(b,a);
r
p
k
