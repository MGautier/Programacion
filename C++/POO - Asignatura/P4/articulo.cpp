#include <iostream>
#include "articulo.h"
#include <iomanip>
#include <set>

using namespace std;

/*
Flujo de salida sera de la forma siguiente:

[110] "Fundamentos de C++", 1998. 29.95€ 
 */

std::ostream& operator << (std::ostream& os, const Articulo& a)
{
  os << "[" << a.referencia() << "] \"" << a.titulo() << "\", de ";
  for(Articulo::Autores::iterator it = a.autores().begin(); it != a.autores().end(); ++it)
    os << (*it)->apellidos();

  os << ". " << (a.f_publi()).anno() << ". " << setiosflags(ios_base::fixed) << setprecision(2) << a.precio() << "€" << endl << "\t"; 
  
  a.imp_esp(os);

  return os;
  /* setiosflags(ios_base:fixed): Fuerza notación fija en números reales
     setpresision(2): Establece a 2 decimales la notación del real */
}

void Cederron::imp_esp(std::ostream& os) const
{
  os << tam() << " MB, ";
  os << stock() << " unidades.";
}

void Libro::imp_esp(std::ostream& os) const
{
  os << n_pag() << " págs., ";
  os << stock() << " unidades.";
    
}

void InformeDigital::imp_esp(std::ostream& os) const
{
  os << "A la venta hasta el " << f_expir() << ".";
}
