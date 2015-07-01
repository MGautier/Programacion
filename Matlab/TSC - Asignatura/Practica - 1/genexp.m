function y = genexp(b,n0,L)
if(L<=0)
    error('genexp:longitud no positiva');
end
nn = n0 + [1:L-1];
y = b.^(-nn);
