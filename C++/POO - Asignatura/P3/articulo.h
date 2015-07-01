#ifndef _ARTICULO_
#define _ARTICULO_

#include "cadena.h"
#include "fecha.h"
#include "usuario.h"
#include <iostream>
#include <map>
#include <iomanip>

class Articulo
{
 public:

  //Métodos observadores
  Cadena referencia() const throw() {return cod_ref_; }
  Cadena titulo() const throw() {return titulo_;}
  Fecha f_publi() const throw() {return fech_publi_;}
  double precio() const throw() {return precio_actual_;}
  unsigned stock() const throw() {return num_ejemplares_;}
  
  //Métodos modificadores
  double& precio() throw() {return precio_actual_;}
  unsigned& stock() throw() {return num_ejemplares_;}
  
  //Constructores

  explicit Articulo(const Cadena& c, const Cadena& t, const Fecha& f, const double& p, const double& n): cod_ref_(c), titulo_(t), fech_publi_(f), precio_actual_(p), num_ejemplares_(n) {}

 private:
  typedef std::map<Usuario*,unsigned> Usuarios;
  Cadena cod_ref_;
  Cadena titulo_;
  Fecha fech_publi_;
  double precio_actual_;
  unsigned num_ejemplares_;
  Usuarios usuarios;
};

std::ostream& operator <<(std::ostream& os, const Articulo& a);

/*
Flujo de salida sera de la forma siguiente:

[110] "Fundamentos de C++", 1998. 29.95€ 
 */


#endif
