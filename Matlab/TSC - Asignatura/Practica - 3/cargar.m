function ejercicio2 = cargar()

% Cargamos el archivo que se nos pide en el ejercicio
load signal.asc;

% La frecuencia a asignar
fs = 8000;

% Numero de pulsos
n = length(signal);

% Ajustamos el tiempo en funcion de la frecuencia
time = 0:1/fs:(n-1)/fs;

ejercicio2 = [time',signal];

% Ahora vamos a reproducir el sonido por los altavoces de nuestro sistema

altavoz = ejercicio2./fs;

% El primer parametro de la funcion nos define el canal de audio
% un vector (mono) y una matriz (stereo); el segundo parametro
% nos define el espectro de audio en el que vamos a representarlo
% (audio mas lento o mas rapido dependiendo del espectro)
% y el ultimo parametro nos dice el numero de muestras o bits
% que se tomaran para hacer la representacion. 

sound(altavoz,fs,8);
