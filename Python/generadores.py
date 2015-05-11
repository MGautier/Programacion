#!/usr/bin/env python

# Las expresiones generadoras funcion de forma muy similar
# a la comprension de listas, cambiando los corchetes por
# parentesis

l = [0, 1, 2, 3]

l2 = (n ** 2 for n in l)

# Sin embargo, las expresiones generadoras devuelven un
# generador

l2 = [n ** 2 for n in l]
print l2
l2 = (n ** 2 for n in l)
print l2

# Un generador es una clase especial de funcion que genera
# valores sobre los que iterar. Para devolver el siguiente valor
# sobre el que iterar se utiliza la palabra clave yield en lugar
# de return

def mi_generador(n, m, s):
    while(n <= m):
        yield n
        n += s
x = mi_generador(0, 5, 1)
print x

# El generador se puede utilizar en cualquier lugar donde se necesite
# un objeto iterable.

for n in mi_generador(0, 5, 1):
    print n

# Siempre es posible crear una lista a partir de un generador mediante
# la funcion list:

lista = list(mi_generador(0, 5, 1))
for n in lista:
    print "lista " + str(n)
