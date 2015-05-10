#!/usr/bin/env python

class Instrumento:
    def __init__(self, precio):
        self.precio = precio

    def tocar(self):
        print "Estamos tocando musica"

    def romper(self):
        print "Eso lo pagas tu"
        print "Son", self.precio, "$$$"

class Bateria(Instrumento):
    pass

class Guitarra(Instrumento):
    pass

#Herencia multiple

class Terrestre:
    def desplazar(self):
        print "El animal anda"

class Acuatico:
    def desplazar(self):
        print "El animal nada"

class Cocodrilo(Terrestre, Acuatico):
    pass

c = Cocodrilo()
c.desplazar()

#Como la clase padre Terrestre se encuentra mas a la izquierda
# seria la definicion de desplazar de esta clase la que prevalece
