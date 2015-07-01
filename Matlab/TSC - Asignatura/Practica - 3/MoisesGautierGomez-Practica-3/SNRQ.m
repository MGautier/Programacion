function y = SNRQ(entrada,error)
%La SNRQ se define como la relacion senal-ruido de cuantificacion
% y es una medida indicativa de la bondad de la cuantificacion.
% Se define como la razon entre la varianza de la senal de entrada y la
% varianza de la señal error de la cuantificacion

% La funcion var se aplica sobre vectores, asi que los parametros de
% entrada, entrada y error, deben ser arrays para poder
% operar con ellos.

varianza_signal = var(entrada);
varianza_error = var(error);

y = 10 * log(varianza_signal/varianza_error) / log(10);