L = 20; %defino una dimension para el vector
nn = 1:L; %Se crea un vector de dimension 20 elementos
imp = zeros(L,1); %Se crea una matriz columna de ceros de dimension 20 x 1
imp(5) = 1; %Le decimos a la matriz imp que en la fila 5 la ponga todo a 1
X = 0.9*imp; %Definimos la funcion que nos pide el enunciado
stem(X); %La representamos en la pantalla