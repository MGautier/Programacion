#!/usr/bin/env python

# Los threads son un concepto similar a los procesos: tambien
# se trata de codigo en ejecucion. Sin embargo los threads se
# ejecutan dentro de un proceso, y los threads del proceso
# comparten recursos entre si.

import threading

class MiThread(threading.Thread):

    def __init__(self, num):
        threading.Thread.__init__(self)
        self.num = num

    def run(self):
        print "Soy el hilo", self.num

# Para que el thread comience a ejecutar su codigo basta con crear una
# instancia de la clase que acabamos de definir y llamar a su metodo
# start.

print "Soy el hilo principal"

for i in range(0, 10):
    t = MiThread(i)
    t.start()
    t.join()

# El metodo join se utiliza para que el hilo que ejecuta la llamada se
# bloquee hasta que finalice el thread sobre el que se llama.

# La forma recomendada de crear nuevos hilos de ejecucion consiste en extender
# de la clase Thread, aunque tambien es posible crear una instancia de Thread
# directamente.


def imprime(num):
    print "Soy el hilo", num

print "Soy el hilo principal"

for i in range(0, 10):
    t = threading.Thread(target=imprime, args=(i, ))
    t.start()


# Sincronizacion

lista = []

lock = threading.Lock()

def anyadir(obj):
    lock.acquire() # Cerrojo
    lista.append(obj)
    lock.release() # Apertura de cerrojo

def obtener():
    lock.acquire()
    obj = lista.pop()
    lock.release()
    return obj

# Semaforos

semaforo = threading.Semaphore(4)

def descargar(url):
    semaforo.acquire()
    urllib.urlretrieve(url)
    semaforo.release()

lista = []
cond = threading.Condition()

def consumir():
    cond.acquire()
    cond.wait()
    obj = lista.pop()
    cond.release()
    return obj

def producir(obj):
    cond.acquire()
    lista.append(obj)
    cond.notify()
    cond.release()

import time

class Hilo(threading.Thread):
    def __init__(self, evento):
        threading.Thread.__init__(self)
        self.evento = evento

    def run(self):
        print self.getName(), "esperando al evento"
        self.evento.wait()
        print self.getName(), "termina la espera"

evento = threading.Event()
t1 = Hilo(evento)
t1.start()
t2 = Hilo(evento)
t2.start()

# Esperamos un poco
time.sleep(5)
evento.set()


def synchronized(lock):
    def dec(f):
        def func_dec(*args, **kwargs):
            lock.acquire()
            try:
                return f(*args, **kwargs)
            finally:
                lock.release()
        return func_dec
    return dec

mi_lock = threading.Lock()

class MiHilo(threading.Thread):
    @synchronized(mi_lock)
    def run(self):
        print "metodo sincronizado"

t = MiHilo().run()
