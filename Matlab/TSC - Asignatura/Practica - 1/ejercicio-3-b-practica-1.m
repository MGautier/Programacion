nn = -10:10; %Defino un vector de 20 elementos
imp = (3*nn*pi) + (pi/2); 
%Multiplico cada elemento del vector por las constantes de la ecuacion
X = sin(imp); %Aplico el seno a cada elemento del vector imp
stem(nn,X); %La representamos en la pantalla