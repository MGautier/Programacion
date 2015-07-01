#ifndef AUTOR_H
#define AUTOR_H
#include "cadena.h"

class Autor{
public:
  Autor(const Cadena& nombre, const Cadena& apellidos, const Cadena& direccion): nombre_(nombre),apellidos_(apellidos),direccion_(direccion) {}
  Cadena nombre() const { return nombre_;}
  Cadena apellidos() const { return apellidos_;}
  Cadena direccion() const { return direccion_;}
					    
private:
  Cadena nombre_, apellidos_, direccion_;
    
};

#endif
