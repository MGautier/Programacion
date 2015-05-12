#!/usr/bin/env python

print "Hola\n\n\tmundo"

#Para que la impresion se realizara en la misma linea tendriamos
# que colocar una coma al final de la sentencia

for i in range(3):
    print i,
print "\n"
for i in range(3):
    print i

#Diferencias entre , y el + en las cadenas: al utilizar las comas
#print introduce automaticamente un espacio para separar cada una
# de las cadenas. Este no es el caso al utilizar el operador +,
# ya que lo que le llega a print es un solo argumento: una cadena
# ya concatenada. Ademas, al utilizar el operador + tendriamos que
# convertir antes cada argumento en una cadena de no serlo ya,
# ya que no es posible concatenar cadenas y otros tipos, mientras
# que al usar el primer metodo no es necesaria la conversion

print "Cuesta", 3, "euros"
#print "Cuesta" + 3 + "euros" #Esto saldria error

# Formateo de salida estandar

print "Hola %s" % "mundo"
print "%s %s" % ("Hola", "mundo")

print "%10s mundo" % "Hola" #Numero de caracteres de esa cadena parametro
print "%-10s mundo" % "Hola" #Numero de caracteres de esa cadena
# en este caso al ser de 4 establecera una separacion de 6 caracteres
# a mundo


from math import pi

print "%.4f" % pi # el .4f especifica el numero de decimales

print "%.4s" % "hola mundo" #especifica el tam maximo de la cadena parametro
