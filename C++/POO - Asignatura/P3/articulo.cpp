#include <iostream>
#include "articulo.h"
#include <iomanip>

using namespace std;

/*
Flujo de salida sera de la forma siguiente:

[110] "Fundamentos de C++", 1998. 29.95€ 
 */

std::ostream& operator << (std::ostream& os, const Articulo& a)
{
  os << "[" << a.referencia() << "] \"" << a.titulo() << "\", ";
  os << (a.f_publi()).anno() << ". " << setiosflags(ios_base::fixed) << setprecision(2) << a.precio() << "€"; 

  return os;
  /* setiosflags(ios_base:fixed): Fuerza notación fija en números reales
     setpresision(2): Establece a 2 decimales la notación del real */
}
