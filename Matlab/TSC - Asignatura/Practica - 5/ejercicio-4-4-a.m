% Como calcular las raices es bastante complicado, utilizaremos
% directamente la funcion residuez para hallar la descomposicion
% de los vectores de coeficientes.

a = [10 -5 1];
b = [1 -5 10];
[r,p,k] = residuez(b,a);
r
p
k
