#ifndef _TARJETA_
#define _TARJETA_

#include <iostream>
#include <map>
#include <iomanip>
#include "fecha.h"
#include "cadena.h"
#include "usuario.h"

class Numero{
private:
  Cadena num_;
public:
  enum Razon {LONGITUD,DIGITOS,NO_VALIDO};
  class Incorrecto{
  private:
    Numero::Razon r_;
  public:
    Incorrecto(const Numero::Razon r):r_(r) {}
    Numero::Razon razon() const {return r_;}
  };//Fin Clase excepción Incorrecta  
  Numero(const Cadena&) throw(Numero::Incorrecto);
  operator const char*() const {return num_.c_str();}
  size_t longitud_num() const throw(){return num_.longitud();}

};//Fin Clase Numero

/*Definición del operador <<menor-que>> para dos objetos Numero */

bool operator <(const Numero& n, const Numero& m); 

class Tarjeta{
  
public:

  typedef std::map<Usuario*, unsigned> Usuarios;

  class Caducada{
  private:
    Fecha caducidad_;
  public:
    Caducada(const Fecha& caducada_): caducidad_(caducada_){}
    Fecha cuando() const {return caducidad_;}
  };//Fin Clase excepción Caducada


  Numero numero() const throw() {return num_tarjeta;}
  Fecha caducidad() const throw() {return fech_caducidad_;}
  Cadena titular_facial() const throw() {return titular_facial_;}
  const Usuario* titular() const throw() {return titular_;}
  void anula_titular() throw();

  //Constructor

  explicit Tarjeta(const Numero&, Usuario&, const Fecha&) throw(Tarjeta::Caducada);

  ~Tarjeta() throw();

private:
  Numero num_tarjeta;
  const Usuario* titular_;
  Fecha fech_caducidad_;
  Cadena titular_facial_;
  Usuarios usuarios_;
  
  //ESTOS METODOS NO SE PUEDEN USAR
  Tarjeta(const Tarjeta&); //Constructor de Copia
  Tarjeta& operator = (const Tarjeta&); //Operador de asignación
  /*--------------------------------------*/

};//Fin Clase Tarjeta

/*Definición del operador <<menor-que>> para dos objetos Tarjeta */

bool operator < (const Tarjeta& t, const Tarjeta& u);

std::ostream& operator << (std::ostream& os, const Tarjeta& t);

/*
Flujo de salida sera de la forma siguiente:

número
titular facial
Caduca: MM/AA
 */


#endif
