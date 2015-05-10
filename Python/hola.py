#!/usr/bin/env python
print "Hola Mundo"

# esto es una cadena

c = "Hola Mundo"

# y esto es un entero

e = 23 #entero (int) para que fuera long tendria que ser 23L
o = 027 # 027 octal = 23 en base 10
h = 0x17 # 0x17 hexadecimal = 23 en base 10
r = 0.2703 #real
exp = 0.1e-3 #exponente
complejo = 2.1 + 7.8j #numero complejo

# podemos comprobarlo con la funcion type
print type(c)
print type(e)
print type(o)
print type(h)
print type(r)
print complejo

a = "uno"
b = "dos"
cad = a + b # c es "unodos"
cad = a * 3 # c es "unounouno"

print cad

# Listas

lista = [22, True, "una lista", [1,2]]
print lista[3]
print lista[3][1]

l = [99, True, "un listado", [4,10]]
mi_var = l[0:2] # mi_var vale [99,True]
print mi_var
mi_var = l[0:4:2] #mi_var vale [99, "un listado"]
print mi_var
mi_var = l[0:-1]
print mi_var
mi_var = l[0:-3]
print mi_var
l[0:2] = [False] #l vale [False, "un listado", [1,2]]
print l

t = 1, 2, 3
print type(t)
t = (1)
print type(t)
t = (1,)
print type(t)

# A diferencia de las listas, las tuplas son inmutables, sus valores no
# se pueden modificar una vez creada; y tienen un tam fijo. Son
# mas ligeras que las listas.

# Diccionarios
# Como clave podemos usar cualquier objeto menos listas o diccionarios

d = {"Philips": "Televisor",
     "LG": "Lavadora",
     "Sony": "Videoconsola"
}
