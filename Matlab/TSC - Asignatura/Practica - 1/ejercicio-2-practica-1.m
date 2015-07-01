nn = 0:49; %Defino un vector de 50 elementos [Longitud = 50]
X = [2;0;0;0;0]*ones(1,10);
%Defino una matriz columna cuyo elemento de la primera fila 
% sera 2 [Amplitud] luego replico dicha columna 10 veces
% para poder extraer el periodo 5 realizando la siguiente operacion
X = X(:); 
%Aqui hago que X sea una matriz columna con los datos anteriores
% lo hago para relacionar cada 5 elementos del vector [matriz fila]
% con el elemento que corresponde [la amplitud] fijado en X
stem(nn,X); %La representamos en la pantalla