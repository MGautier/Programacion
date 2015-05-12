#!/usr/bin/env python

import socket

socket_c = socket.socket()

socket_c.connect(("localhost", 9999))

while True:
    mensaje = raw_input("> ")
    socket_c.send(mensaje)
    if mensaje == "quit":
        break

print "adios"

socket_c.close()
