#ifndef _CADENA_
#define _CADENA_

#include <iostream>
#include <cstdio>
#include <cstring>
#include <stdexcept>


class Cadena{

 public:
  explicit Cadena(size_t t=0, char c=' '); //Ctor
  Cadena(const Cadena& ); //Ctor. copia
  Cadena(const char*); //Constructor de Cadena (bajo nivel) a Cadena


  //Operadores

  Cadena& operator =(const Cadena& c); //Una Cadena podrá asignarse a otra.
  Cadena operator =(const char* c); //Una Cadena (bajo nivel) podrá asignarse directamente a una Cadena

  Cadena& operator += (const Cadena& c); //Concatenar c al final de Cadena

  friend Cadena operator +(const Cadena& c, const Cadena& d); //Concatenar dos Cadenas

  friend bool operator ==(const Cadena& c, const Cadena& d);
  friend bool operator !=(const Cadena& c, const Cadena& d);
  friend bool operator >(const Cadena& c, const Cadena& d);
  friend bool operator <(const Cadena& c, const Cadena& d);
  friend bool operator >=(const Cadena& c, const Cadena& d);
  friend bool operator <=(const Cadena& c, const Cadena& d);

  operator const char*() const; //Conversión automática o implícita

  //Metodos observadores y modificadores

  size_t longitud() const; //numero caracteres de una Cadena

  char operator [](const size_t t) const
  { return cad_[t];}
  char& operator [](const size_t t)
  { return cad_[t];}

  char& at(const size_t t) throw(std::out_of_range);
  const char at(const size_t t) const throw(std::out_of_range);

  Cadena subcadena (const size_t indice, size_t t) const throw(std::out_of_range);

  //Destructor

  ~Cadena();

  
 private:
  size_t tam_;
  char* cad_;
  

};

//Flujo de entrada y salida

//std::ostream& operator <<(std::ostream&, const Cadena&);

//std::istream& operator >>(std::istream&, Cadena&);

#endif
