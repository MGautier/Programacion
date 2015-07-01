function [x,y] = trenImpulsos (amp,anch,p,ini,fin)

if(fin < ini)
    error ('El fin del intervalo debe ser mayor que el inicio');
end

y=zeros(fin-ini,1);
for i=ini:fin
    if(mod(i,p)==0) | (mod(i,p)<=anch)
        y(i-ini+1)=1;
    end
end
y = amp*y;
x=ini:fin;
