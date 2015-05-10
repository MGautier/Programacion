#!/usr/bin/env python

#funcion

def mi_funcion(param1, param2):
    print param1
    print param2

#docstring

def otra_funcion(param1, param2):
    """Esta funcion imprime los dos valores pasados
    como parametros"""
    print param1
    print param2

mi_funcion("hola",2)
otra_funcion(param2 = 2, param1 = "hola")

def imprimir(texto, veces = 1):
    print veces * texto

imprimir("hola")
imprimir("hola", 2)

# si ponemos * es una tupla, ** es un diccionario
def varios(param1, param2, *otros):
    for val in otros:
        print otros

varios(1, 2)
varios(1, 2, 3)
varios(1, 2, 3, 4)

def mas_varios(param1, param2, **otros):
    for i in otros.items():
        print i

mas_varios(1, 2, tercero = 3)

def f(x, y):
    x = x + 3
    y.append(23)
    print x, y

x = 22 #Entero valor inmutable
y = [22] #Lista valor mutable
f(x, y)
print x, y

#Los valores mutables se comportan como paso por referencia
#, y los inmutables como paso por valor

def sumar(x, y):
    return x + y

print sumar(3, 2)

def f_otro(x, y):
    return x * 2, y * 2 #devuelve una tupla al vuelo

a, b = f_otro(1, 2)
print a, b
