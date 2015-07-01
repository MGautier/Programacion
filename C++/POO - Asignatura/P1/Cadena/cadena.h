
#ifndef _CADENA_
#define _CADENA_

#include <iostream>
#include <cstdio>
#include <cstring>
#include <stdexcept>



class Cadena{

 public:
  explicit Cadena(size_t t=0, const char c=' ') throw(); //Ctor
  Cadena(const Cadena& c) throw(); //Ctor. copia
  Cadena(const char* c) throw(); //Constructor de Cadena (bajo nivel) a Cadena


  //Operadores

  Cadena& operator =(const Cadena& c) throw(); //Una Cadena podrá asignarse a otra.
  Cadena& operator =(const char* c) throw(); //Una Cadena (bajo nivel) podrá asignarse directamente a una Cadena

  Cadena& operator += (const Cadena& c) throw(); //Concatenar c al final de Cadena
  //operator const char*() const; //Conversión automática o implícita

  //Metodos observadores y modificadores

  const char* c_str() const throw();
  size_t longitud() const throw(); //numero caracteres de una Cadena

  char operator [](const size_t t) const throw()
	{return cad_[t]; }
  char& operator [](const size_t t) throw()
	{return cad_[t]; }

  char& at(const size_t t) throw(std::out_of_range);
  const char at(const size_t t) const throw(std::out_of_range);

  Cadena subcadena (const size_t indice, size_t t) const throw(std::out_of_range);

  //Destructor

  ~Cadena() throw();

  
 private:
  size_t tam_;
  char* cad_;
  

};


  Cadena operator +(const Cadena& c, const Cadena& d) throw(); //Concatenar dos Cadenas

  bool operator ==(const Cadena& c, const Cadena& d) throw();
  bool operator !=(const Cadena& c, const Cadena& d) throw();
  bool operator >(const Cadena& c, const Cadena& d) throw();
  bool operator <(const Cadena& c, const Cadena& d) throw();
  bool operator >=(const Cadena& c, const Cadena& d) throw();
  bool operator <=(const Cadena& c, const Cadena& d) throw();

//Flujo de entrada y salida

std::ostream& operator <<(std::ostream&, const Cadena&) throw();

std::istream& operator >>(std::istream&, Cadena&) throw();

#endif
