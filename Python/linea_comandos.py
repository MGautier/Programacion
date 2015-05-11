#!/usr/bin/env python

# Para poder obtener datos o parametros a la hora de llamar
# al programa por la linea de comandos tenemos que usar
# sys.argv.

# Para poder usar dicha variable debemos importar el modulo sys.
# sys.argv[0] contiene siempre el nombre del programa tal como lo ha
# ejecutado el usuario, sys.argv[1], si existe, seria el primer parametro
# sys.argv[2] el segundo y asi sucesivamente

import sys

if(len(sys.argv) > 1):
    print "Abriendo " + sys.argv[1]
else:
    print "Debes indicar el nombre del archivo"

# Tambien se podria usar optparse
