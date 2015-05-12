#!/usr/bin/env python

f = open("texto.txt", "r+")

# Leer archivo

completo = f.read() # Devuelve una cadena con el contenido del archivo
print completo

parte = f.read(512) #O bien el contenido de los primeros n bytes
#print parte

while True:
    linea = f.readline() # Sirve para leer lineas del fichero una por una
    if not linea: break
    print line

# Tambien existe el metodo readlines, que lee todas las lineas del archivo
# y devolviendo una lista con las lineas leidas

# Escritura de archivos

f.write("Funciona")

f.writelines(["1", "2"])

f.close()
