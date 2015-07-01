nn = 0:50; %Defino un vector de 20 elementos
imp = (nn*pi/sqrt(23));
%Multiplico cada elemento del vector por las constantes de la ecuacion
X = cos(imp); %Aplico el coseno a cada elemento del vector imp
stem(nn,X); %La representamos en la pantalla