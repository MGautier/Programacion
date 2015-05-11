#!/usr/bin/env python

S.count(sub[, start[, end]])

#Devuelve el numero de veces que se encuentra sub en la cadena. Los
# parametros opcionales start y end definen una subcadena en la que
# buscar

S.find(sub[, start[, end]])

#Devuelve la posicion en la que se encontro por primera vez sub en la
# cadena o -1 si no se encontro

S.join(sequence)

#Devuelve una cadena resultante de concatenar las cadenas de la
# secuencia seq separadas por la cadena sobre la que se llama
# el metodo

S.partition(sep)

#Busca el separador sep en la cadena y devuelve una tupla con la
# subcadena hasta dicho separador, el separador en si, y la subcadena
# del separador hasta el final de la cadena. Si no se encuentra,
# el separador, la tupla contendrá la cadena en si y dos cadenas
# vacias

S.replace(old, new[, count])

# Devuelve una cadena en la que se han reemplazado todas las ocurrencias
# de la cadena old por la cadena new. Si se especifica el parametro count
# , este indica el numero maximo de ocurrencias a reemplazar

S.split([sep [, maxsplit]])

# Devuelve una lista conteniendo las subcadenas en las que se divide
# nuestra cadena al dividirlas por el delimitador sep. En el caso de
# que no se especifique sep, se usan espacios. Si se especifica maxsplit
# , este indica el numero maximo de particiones a realizar
