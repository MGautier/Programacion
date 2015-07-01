#include <iostream>
#include "tarjeta.h"

using namespace std;

/* Implementación Clase Numero */

Numero::Numero(const Cadena& c) throw(Numero::Incorrecto)
{
  Cadena cad_;
  
  for( unsigned i=0; i<c.longitud();++i)
    {
      if(c[i] - '0' >=0 && c[i] - '9' <=9)
	{
	  Cadena aux_(1,c[i]);
	  cad_+=aux_;
	}
      else
	if(!isspace(c[i]))
	  throw Incorrecto(DIGITOS);
    }

  num_ = cad_;

  //Algoritmo de Luhn

  size_t n = num_.longitud();
  if (n < 13 || n > 19)
    throw (Numero::Incorrecto(LONGITUD));
  size_t suma = 0;
  bool alt = false;
  for (int i = n - 1; i > -1; --i) {
        n = num_[size_t(i)] - '0';
        if (alt) {
	  n *= 2;
	  if (n > 9)
	    n = (n % 10) + 1;
        }
        alt = !alt;
        suma += n;
  }
  if (suma % 10 != 0)
    throw Numero::Incorrecto(NO_VALIDO);
  
}


bool operator <(const Numero& n, const Numero& m)
{
  return (strcmp(n,m) < 0);
}


/* Implementación Clase Tarjeta */

Tarjeta::Tarjeta(const Numero& n, Usuario& u, const Fecha& f) throw(Tarjeta::Caducada) : num_tarjeta(n), titular_(&u)
{
  Fecha actual;

  if(f < actual)
    throw Caducada(f);

  fech_caducidad_ = f;
  titular_facial_ = u.nombre()+" "+u.apellidos();
  u.es_titular_de(*this);
}

Tarjeta::~Tarjeta() throw()
{
  if(titular_ != 0)
    {
      Usuario* u = const_cast<Usuario*>(titular_);   /* puntero Usuario constante -> puntero Usuario no constante */
      u->no_es_titular_de(*this);
    }
}

void Tarjeta::anula_titular() throw()
{
  titular_ = 0;
}

std::ostream& operator << (std::ostream& os, const Tarjeta& t)
{
  unsigned i,j;

  os << t.numero() << endl;
  os << t.titular_facial() << endl;
  os << "Caduca: ";

  /* Al hacer la división entre 100 la parte decimal correspondería a los
     dos últimos digitos del año, pero como la división es por defecto elimina
     dichos valores quedando la parte entera. Por lo tanto al hacer la resta
     (i-j) (2009 - 2000) quedaría el último o los dos últimos dígitos del anyo
     que queremos */

  i=t.caducidad().anno();
  j=i/100;
  j*=100;
  i-=j;

  if(t.caducidad().mes() < 10)
    os << 0;
  
  os<<t.caducidad().mes() << "/";

  if(i < 10)
    os << 0;
  
  os << i << endl;

  return os;
}

bool operator < (const Tarjeta& t, const Tarjeta& u)
{
  return (t.numero() < u.numero());
}
