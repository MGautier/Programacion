#!/usr/bin/env python

def division(a, b):
    return a / b

def calcular():
    division(1, 0)

#calcular()

try:
    f = file("archivo.txt")
except:
    print "El archivo no existe"


try:
    num = int("3a")
    print no_existe
except NameError:
    print "La variable no existe"
except ValueError:
    print "El valor no es un numero"

#Tambien se puede poner except a modo de tupla
# except(NameError, ValueError):

try:
    num = 33
except:
    print "Hubo un error!"
else:
    print "Todo esta bien"

# Este else define un fragmento de codigo a ejecutar solo si no se ha
# producido ninguna excepcion en el try

x = 8
y = 2

try:
    z = x / y
except ZeroDivisionError:
    print "Division por cero"
finally:
    print "Limpiando"

# finally se ejecuta siempre, se produzca o no una excepcion

class MiError(Exception):
    def __init__(self, valor):
        self.valor = valor
    def __str__(self):
        return "Error " + str(self.valor)
resultado = 21
try:
    if resultado > 20:
        raise MiError(33)
except MiError, e:
    print e
