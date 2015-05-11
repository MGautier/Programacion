#!/usr/bin/env python

class Ejemplo:
    def publico(self):
        print "Publico"

    def __privado(self):
        print "Privado"

ej = Ejemplo()
ej.publico()
#ej.__privado()  en este caso al ser el metodo privado, privado por los dos guiones
# iniciales, da un error de no encontrarlo en la clase


ej._Ejemplo__privado() #Trampa para poder acceder al metodo privado de la clase

class Fecha():
    def __init__(self):
        self.__dia = 1

    def getDia(self):
        return self.__dia

    def setDia(self, dia):
        if dia > 0 and dia < 31:
            self.__dia = dia
        else:
            print "Error"

mi_fecha = Fecha()
mi_fecha.setDia(29)
print "Mi dia es " + str(mi_fecha.getDia())


#Otra forma de acceder directamente a los atributos internos
# de una clase

class Otro(object):
    def __init__(self):
        self.__dia = 1

    def getDia(self):
        return self.__dia

    def setDia(self, dia):
        if dia > 0 and dia < 31:
            self.__dia = dia
        else:
            print "Error"

    dia = property(getDia, setDia)

mi_otra_fecha = Otro()
mi_otra_fecha.dia = 29
print "Mi dia es " + str(mi_otra_fecha.dia)


# Metodos especiales de las clases

# __init__(self, args) Metodo de inicializacion del objeto

# __new__(cls, args) Se encarga de construir y devolver el objeto
# en si. Es un metodo estatico que existe con independencia de las
# instancias de la clase: es un metodo de clase, no de objeto y
# por lo tanto el primer parametro no es self, sino la propia
# clase: cls

# __del__(self) Metodo llamado cuando el objeto va a ser borrado
# Destructor

# __str__(self) Metodo llamado para crear una cadena de texto
# que represente a nuestro objeto

# __cmp__(self, otro) Metodo llamado cuando se utilizan los operadores
# de comparacion para comprobar si el objeto es menor, mayor o igual
# al objeto pasado como parametro. negativo -> menor, cero -> igual
# positivo -> mayor

# __len__(self) Metodo llamado para comprobar la longitud del objeto.
