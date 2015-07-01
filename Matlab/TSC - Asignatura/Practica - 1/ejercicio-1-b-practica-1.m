L = 11; %defino una dimension para el vector
nn = -10:0; %Se crea un vector de dimension 11 elementos
imp = [zeros(1,3),1,zeros(1,7)]; 
%Se crea una matriz fila en donde los 3 primeros elementos son cero,
% el cuarto 1 y los restantes ceros.
X = 4.5 * imp; %Definimos la funcion que nos pide el enunciado
stem(nn,X); %La representamos en la pantalla