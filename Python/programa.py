#!/usr/bin/env python

import modulo, os, sys
from time import asctime
#aunque es mala practica, tambien se puede importar
# todos los nombres del modulo al espacio de nombres
# actual usando el caracter * -> from time import *

modulo.mi_funcion()

# print time.asctime() cuando no hemos importado
# al espacio de nombres el modulo en concreto

print asctime()
print sys.path
