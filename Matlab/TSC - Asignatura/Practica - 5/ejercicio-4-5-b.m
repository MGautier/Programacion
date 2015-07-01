% Se nos pide que calculemos la respuesta transitoria de la respuesta
% total de la signal anterior.

% rgp = respuesta en regimen permanente
% rt = respuesta transitoria

rgp = 3;
rt = y - rgp;
plot(rt)
xlabel('Longitud')
ylabel('Coeficientes')
title('\it{Respuesta transitoria obtenida del escalon}','FontSize',14)
