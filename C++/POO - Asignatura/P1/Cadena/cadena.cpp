#include <iostream>
#include <cstdio>
#include <stdexcept>
#include <cstring>
#include "cadena.h"


using namespace std;

Cadena::Cadena(size_t t, const char c) throw()
{
  cad_ = new char[t+1];
  tam_ = t;

  memset(cad_,c,t);

  cad_[t] = '\0';
}

Cadena::Cadena(const Cadena& c) throw()
{
  cad_ = new char[c.longitud() + 1];

  strcpy(cad_,c.cad_);
  tam_ = c.longitud();
}

Cadena::Cadena(const char* c) throw()
{
  cad_ = new char[strlen(c) + 1];
  tam_ = strlen(c);
  strcpy(cad_,c);
}

Cadena& Cadena::operator =(const Cadena& c) throw()
{
  if(this != &c) //Comprobamos si es o no la misma Cadena para no tener que realzar todos los pasos siguientes
    {
      delete[] cad_;
      cad_ = new char[c.longitud() + 1];
      tam_ = c.longitud();
      strcpy(cad_,c.cad_);
    }

  return *this; //Devolvemos la nueva cadena creada
}

Cadena& Cadena::operator =(const char* c) throw()
{
  delete[] cad_;
  tam_ = strlen(c);
  cad_ = new char[tam_ + 1];
  strcpy(cad_,c);
  return *this;
}

Cadena& Cadena::operator += (const Cadena& c) throw()
{
  tam_ = tam_ + c.longitud();
  char* cad_aux = new char[longitud() + 1];
  
  strcpy(cad_aux,cad_);
  delete[] cad_; //Borramos cadena antigua

  cad_ = new char[tam_ + 1]; //Reservamos memoria para el atributo con un índice de elementos mayor

  strcpy(cad_,cad_aux);
  strcat(cad_,c.cad_);
  delete[] cad_aux;

  return *this;
}

Cadena operator +(const Cadena& c, const Cadena& d) throw()
{
  char* cad = new char[(c.longitud() + d.longitud()) + 1];
  
  strcpy(cad,c.c_str());
  strcat(cad,d.c_str());

  Cadena auxiliar(cad);
  delete[] cad;
  return auxiliar;

}

bool operator ==(const Cadena& c, const Cadena& d) throw()
{
  return strcmp(c.c_str(),d.c_str()) == 0;
}

bool operator !=(const Cadena& c, const Cadena& d) throw()
{
  return !(c==d);
}

bool operator >(const Cadena& c, const Cadena& d) throw()
{
  return strcmp(c.c_str(),d.c_str()) > 0;
}

bool operator <(const Cadena& c, const Cadena& d) throw()
{
  return strcmp(c.c_str(),d.c_str()) < 0;
}

bool operator >=(const Cadena& c, const Cadena& d) throw()
{
  return strcmp(c.c_str(),d.c_str()) >= 0;
}

bool operator <=(const Cadena& c, const Cadena& d) throw()
{
  return strcmp(c.c_str(),d.c_str()) <= 0;
}

const char* Cadena::c_str() const throw()
{
  return cad_;  
}


size_t Cadena::longitud() const throw()
{
  return tam_;
}

char& Cadena::at(const size_t t) throw(std::out_of_range)
{
  if(t < 0)
   throw out_of_range("Error no se puede acceder al indice");
	
  if(longitud() == 0 || t > (longitud()-1))
   throw out_of_range("Error no se puede acceder al indice");

  return cad_[t];
}

const char Cadena::at(const size_t t) const throw(std::out_of_range)
{
  if(t < 0)
   throw out_of_range("Error no se puede acceder al indice");

  if(longitud() == 0 || t > (longitud()-1))
    throw out_of_range("Error no se puede acceder al indice");
  
  return cad_[t];
}

Cadena Cadena::subcadena (const size_t indice, size_t t) const throw(std::out_of_range)
{

  at(indice); //posición inicial anterior al indice
  at(indice+t); //posición inicial después del índice
  at(t); //la subcadena se sale de los límites

  Cadena c(t);
  size_t j=0;
  t+=indice;
  for(size_t i=indice; i<t; i++)
    {
      c.cad_[j]=cad_[i];
      j++;
    }
  c.cad_[j]='\0';
  return c;
}

Cadena::~Cadena() throw()
{
  delete[] cad_;
}

std::ostream& operator <<(std::ostream& os, const Cadena& entrada) throw()
{
  os << entrada.c_str();
  return os;
}

std::istream& operator >>(std::istream& is, Cadena& entrada) throw()
{
  char texto[32] = {0};
  is.width(32);
  is >> texto;
  entrada = texto;
  return is;

  /* La funcion width() especifica el numero minimo de caracteres a utilizar
     para la siguiente operacion de salida <<. */

}
