#!/usr/bin/env python

# Un decorador no es mas que una funcion que recibe una funcion
# como parametro y devuelve otra funcion como resultado

def mi_decorador(funcion):
    def nueva(*args):
        print "Llamada a la funcion ", funcion.__name__
        retorno = funcion(*args)
        return retorno
    return nueva

def imp(cadena):
    print cadena

mi_decorador(imp)("hola")

# Para facilitar la sintaxis podemos hacer lo siguiente

@mi_decorador
def imprimir(s):
    print s

# Si quisieramos aplicar mas de un decorador bastaria con incluir
# una nueva linea con el nuevo decorador.
# @otro_decorador
# @mi_decorador
# def ---
# Es importante advertir que los decoradores se ejecutaran de abajo
# a arriba, es decir, primero mi_decorador y despues otro_decorador

imprimir("adios")
