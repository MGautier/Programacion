#!/usr/bin/env python

#raw_input: Esta funcion toma como parametro una cadena a usar
# como prompt y devuelve una cadena con los caracteres
# introducidos por el usuario hasta que pulso la tecla Enter

nombre = raw_input("Como te llamas? ")
print "Encantado, " + nombre

try:
    edad = raw_input("Cuantos anyos tienes? ")
    dias = int(edad) * 365
    print "Has vivido " + str(dias) + " dias"
except ValueError:
    print "Eso no es un numero"
