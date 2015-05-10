#!/usr/bin/env python

class Coche:
    """Abstraccion de los objetos coche."""
    def __init__(self, gasolina):
        self.gasolina = gasolina
        print "Tenemos", gasolina, "litros"

    def arrancar(self):
        if self.gasolina > 0:
            print "Arranca"
        else:
            print "No arranca"

    def conducir(self):
        if self.gasolina > 0:
            self.gasolina -= 1
            print "Quedan", self.gasolina, "litros"
        else:
            print "No se mueve"

mi_coche = Coche(3)

print mi_coche.gasolina
mi_coche.arrancar()
mi_coche.conducir()
mi_coche.conducir()
mi_coche.conducir()
mi_coche.conducir()
mi_coche.arrancar()
print mi_coche.gasolina
