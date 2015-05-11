#!/usr/bin/env python

#El concepto de funciones de orden superior se refiere
# al uso de funciones como si de un valor cualquiera se tratara,
# posibilitando el pasar funciones como parametros de otras
# funciones o devolver funciones como valor de retorno

# Esto es posible porque en Python todo son objetos.

def saludar(lang):
    def saludar_es():
        print "Hola"
    def saludar_en():
        print "Hi"
    def saludar_fr():
        print "Salut"

    lang_func = {"es": saludar_es,
                 "en": saludar_en,
                 "fr": saludar_fr}

    return lang_func[lang]

f = saludar("es")
f()

# Como el valor de retorno de saludar es una funcion, esto
# quiere decir que f es una variable que contiene una funcion.
# Podemos entonces llamar a la funcion a la que se refiere f de la forma
# en que llamariamos a cualquier otra funcion, incluyendo unos parentesis y,
# de forma opcional, una serie de parametros entre los parentesis

saludar("en")()
saludar("fr")()

# En este caso el primer par de parentesis indica los parametros de la
# funcion saludar, y el segundo par, los de la funcion devuelta
# por saludar

def cuadrado(n):
    return n ** 2

l = [1, 2, 3]
l2 = map(cuadrado, l)
# Map aplica una funcion a cada elemento de una secuencia y
# devuelve una lista con el resultado de aplicar la funcion a cada
# elemento. Si se pasan como parametros n secuencias, la funcion
# tendra que aceptar n argumentos
print l2

def es_par(n):
    return (n % 2.0 == 0)

#filter verifica que los elementos de una secuencia cumplan una
# determinada condicion, devolviendo una secuencia con los
# elementos que cumplen esa condicion. Para cada elemento de la secuencia
# se aplica la funcion; si el resultado es True se incluye en la
# lista y en caso contrario se descarta.

l3 = filter(es_par, l)
print l3

# reduce: aplica una funcion a pares de elementos de una secuencia hasta
# dejarla en un solo valor

def sumar(x, y):
    return x + y

l4 = reduce(sumar, l)
print l4

# funcion lambda

l5 = filter(lambda n: n % 2.0 == 0, l)
print l5

# Comprension de listas

l6 = [n ** 2 for n in l]
print l6

# Esta expresion se leeria como "para cada n en l haz n**2"

l7 = [n for n in l if n % 2.0 == 0]
print l7

#Esta expresion es similar a la usada con filter

l = [0, 1, 2, 3]
m = ["a", "b"]
n = [s * v for s in m
     for v in l
     if v > 0]
print n


n = []
for s in m:
    for v in l:
        if v > 0:
            n.append(s * v)
print n
