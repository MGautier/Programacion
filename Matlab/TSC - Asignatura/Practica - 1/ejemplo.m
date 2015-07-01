%Funcion: X(n) = b^n
function y = genexp(b,n_0,L)
if(L \leq 0)
   error('GENEXP: longitud no positiva')
end

nn = n_0 + [1:L];
y = b^{nn};
end$
