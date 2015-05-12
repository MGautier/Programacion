#!/usr/bin/env python

import re

if re.match("python", "python"):
    print "cierto"

# el . es el caracter comodin: la expresion regular ".ython" describiria
# a todas las cadenas que consistan en un caracter cualquiera,
# menos el de nueva linea, seguido de "ython". Un caracter cualquier y solo
# uno. No cero, ni dos, ni tres

if re.match(".ython", "python"):
    print "otra vez cierto"

if re.match(".ython", "jython"):
    print "mas cierto todavia"

# Para comprobar si la cadena consiste en 3 caracteres seguidos de un
# punto:

if re.match("...\.", "abc."):
    print "Ahi vamos"

# Si necesitaramos una expresion que solo resultara cierta para las
# cadenas "python", "jython" y "cython" y ninguna otra, podriamos
# utilizar el caracter "|"

if re.match("python|jython|cython", "python"):
    print "coincide"

# Grupos en expresiones regulares: Los grupos tienen una gran
# importancia a la hora de trabajar con expresiones regulares

re.match("(p|j|c)ython", "python")
re.match("[p|j|c]ython", "python")
re.match("python[0-9]", "python0")
re.match("python[0-9a-zA-Z]", "pythonp")


# Dentro de las clases de caracteres, los caracteres especiales
# no necesitan ser escapados.

re.match("python[.,]", "python.")

#y no

re.match("python[\.,]", "python.")

# Los conjuntos de caracteres tambien se pueden negar utilizando
# el simbolo '^'.

re.match("python[^0-9a-z]", "python+")

# Esto indicaria que nos interesan las cadenas que comiencen
# por python y tengan como ultimo caracter algo que no sea
# ni una letra minuscula ni un numero

mo = re.match("http://.+\es", "http://ugr.es")
print mo.group()

mo = re.match("http://(.+)\es", "http://ugr.es")
print mo.group(0)
print mo.group(1)

mo = re.match("http://(.+)(.{3})", "http://ugr.es")

print mo.groups()
