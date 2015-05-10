#!/usr/bin/env python

fav = "ugr.es"
#si (if) fav es igual a "ugr.es"
if fav == "ugr.es":
    print "La pagina de mi univ"
    print "Ha funcionado"


#if-else

if fav != "ugr.es":
    print "Sigue funcionando"
else:
    print "Oh my goooood"

#if-elif-elif-else

numero = 10

if numero < 0:
    print "Negativo"
elif numero > 0:
    print "Positivo"
else:
    print "Cero"

#A if C else

var = "par" if (numero % 2 == 0) else "impar"
print var
