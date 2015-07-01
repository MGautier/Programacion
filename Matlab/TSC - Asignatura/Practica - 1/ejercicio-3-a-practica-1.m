nn = 0:25; %Defino un vector de 25 elementos
imp = nn * pi/17; 
%Defino una parte de la ecuacion que nos piden multiplicando
% cada elemento del vector por la parte fija pi/17.
X = sin(imp); %Defino el seno sobre el valor del vector imp
stem(nn,X); %La representamos en la pantalla