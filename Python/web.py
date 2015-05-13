#!/usr/bin/env python

import urllib, urllib2, cookielib
from urllib2 import HTTPBasicAuthHandler

try:
    f = urllib2.urlopen("http://www.python.org")
    print f.read()
    f.close()
except HTTPError, e:
    print "Ocurrio un error"
    print e.code
except URLError, e:
    print "Ocurrio un error"
    print e.reason


params = urllib.urlencode({"usuario": "manuel",
                           "password": "contrasenya"})
# f = urllib2.urlopen("http://ejemplo.com/login", params)

# La funcion urlretrieve toma como parametros la URL a descargar
# y, opcionalmente, un parametro filename con la ruta local en la
# que guardar el archivo, un parametro data similar al de urlopen y
# un parametro reporthook con una funcion que utilizar para informar
# del progreso.

params = urllib.urlencode({"usuario": "manuel",
                           "password": "contrasenya"})

#f = urllib2.urlopen("http://ejemplo.com/login" + "?" + params)

# La clase Request define objetos que encapsular toda la informacion
# relativa a una peticion. A traves de este objetos podemos realizar
# peticiones mas complejas, incluyendo nuestras propias cabeceras, como
# el User-Agent

# Por defecto urllib2 se identifica como "Python-urllib/2.5"; si
# quisieramos identificarnos como un Linux corriendo Konqueror por
# ejemplo:

ua = "Mozilla/5.0 (compatible; Konqueror/3.5.8; Linux)"
h = {"User-Agent": ua}
r = urllib2.Request("http://www.python.org", headers=h)
f = urllib2.urlopen(r)
print f.read()

# Para personalizar la forma en que trabaja urllib2 podemos instalar un
# grupo de manejadores (handlers) agrupados en un objeto de la clase
# OpenerDirector (opener), que sera el que se utilice a partir de ese
# momento al llamar a urlopen


aut_h = urllib2.HTTPBasicAuthHandler()
aut_h.add_password("realm", "host", "usuario", "password")

opener = urllib2.build_opener(aut_h)
urllib2.install_opener(opener)

f = urllib2.urlopen("http://www.python.org")


# Si quisieramos especificar un proxy en el codigo tendriamos que
# utilizar un opener que contuviera el manejador ProxyHandler

proxy_h = urllib2.ProxyHandler({"http" : "http://miproxy.net:123"})

opener = urllib2.build_opener(proxy_h)

urllib2.install_opener(opener)

#f = urllib2.urlopen("http://www.python.org")

# Para que se guarden las cookies que manda HTTP utilizamos el manejador
# HTTPCookieProcessor

cookie_h = urllib2.HTTPCookieProcessor()

opener = urllib2.build_opener(cookie_h)

urllib2.install_opener(opener)

f = urllib2.urlopen("http://www.python.org")

# Si queremos acceder a estas cookies o poder mandar nuestras propias
# cookies, podemos pasarle como parametro al inicializador de
# HTTPCookiProcessor un objeto de tipo CookiJar del modulo cookielib

# Para leer las cookies mandadas basta con crear un objeto iterabe a partir
# del CookieJar

cookie_j = cookielib.CookieJar()

cookie_h = urllib2.HTTPCookieProcessor(cookie_j)

opener = urllib2.build_opener(cookie_h)

opener.open("http://www.python.org")

for num, cookie in enumerate(cookie_j):
    print num, cookie.name
    print cookie.value
    print
