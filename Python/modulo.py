#!/usr/bin/env python

def mi_funcion():
    print "una funcion"

class MiClase:
    def __init__(self):
        print "una clase"

print "un modulo"
print "Se muestra siempre"

if __name__ == "__main__":
    print "Se muestra si no es importacion"

# Se muestra el print si el modulo se invoc como programa y no
# como importacion de modulo en otro programa
