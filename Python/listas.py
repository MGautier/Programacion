#!/usr/bin/env python

L.append(object)

#Inserta un objeto al final de la lista

L.count(value)

#Devuelve el numero de veces que se encontro value en la lista

L.extend(iterable)

#Inserta los elementos del iterable en la lista

L.index(value[, start[, stop]])

#Devuelve la posicion en la que se encontro la primera ocurrencia de
# value. Si se especifican, start y stop definen las posiciones de inicio
# y fin de una sublista en la que buscar

L.insert(index, object)

# Inserta el objeto object en la posicion index

L.pop([index])

# Devuelve el valor en la posicion index y lo elimina de la lista. Si no
# se especifica la posicion, se utiliza el ultimo elemento de la lista.

L.remove(value)

# Elimina la primera ocurrencia de value en la lista

L.reverse()

# Invierte la lista. Esta funcion trabaja sobre la propia lista desde la
# que se invoca el metodo, no sobre una copia

L.sort(cmp=None, key=None, reverse=False)

#Ordena la lista. Si se especifica cmp, este debe ser una funcion que tome como parametro
# dos valores x e y de la lista y devuelva -1 si x es menor que y, 0 si son iguales y 1
# si x es mayor que y.

#El parametro reverse es un booleano que indica si se debe ordenar
# la lista de forma inversa, lo que seria equivalente a llamar
# primero a L.sort() y despues a L.reverse()

# Por ultimo, si se especifica, el parametor key debe ser una funcion
# que tome un elemento de la lista y devuelva una clave a utilizar
# a la hora de comparar, en lugar del elemento en si.
