#include <iostream>
#include <cstdlib>
#include <iomanip>
#include "usuario.h"
#include "tarjeta.h"
#include "articulo.h"


using namespace std;

set<Cadena> Usuario::conj_ids;

Usuario::Usuario(const Cadena& id, const Cadena& nom, const Cadena& apell, const Cadena& direc, const Clave& key) throw(Usuario::Id_duplicado): password_(key)
{
  if((conj_ids.insert(id)).second == false)
    throw Id_duplicado(id);

  conj_ids.insert(id); //Insertamos el nuevo identificador
  identificador_ = id;
  nombre_ = nom;
  apellidos_ = apell;
  direccion_ = direc;
  
}

Usuario::~Usuario()
{
  for (Usuario::Tarjetas::const_iterator iter = tarjetas().begin() ; iter != tarjetas().end() ; iter++)
    {
      (iter->second)->anula_titular();
    }
  conj_ids.erase(identificador_);
  
}

void Usuario::es_titular_de(Tarjeta& t) throw()
{
  if(t.titular() == this)
    tarjetas_.insert(make_pair(t.numero(),&t));
  //tarjetas_[t.numero()]=&t; Sería lo mismo que la linea anterior
}

void Usuario::no_es_titular_de(Tarjeta& t) throw()
{
  tarjetas_.erase(t.numero());
  t.anula_titular();
  
}

Cadena Usuario::id() const throw()
{
  return identificador_;
}

Cadena Usuario::nombre() const throw()
{
  return nombre_;
}

Cadena Usuario::apellidos() const throw()
{
  return apellidos_;
}

Cadena Usuario::direccion() const throw()
{
  return direccion_;
}

const Usuario::Tarjetas& Usuario::tarjetas() const throw()
{
  return tarjetas_;
}

const Articulos& Usuario::compra() const throw()
{
  return articulos_;
}

size_t Usuario::n_articulos() const throw()
{
  return articulos_.size();
}

void Usuario::compra(Articulo& a, unsigned cant_) throw()
{

  if(cant_ == 0)
    articulos_.erase(&a);
  
  if(cant_ > 0)
    articulos_[&a]=cant_;

  /* Otra forma de hacerlo
  if(cant_ == 0)
    {
      Articulos::iterator it = articulos_.find(a);
      a.erase(it);
    }
  
  if(cant_ > 0)
  a.insert(make_pair(&a,cant_));*/
}

std::ostream& operator << (std::ostream& os, const Usuario& u)
{
  os << u.id() << " [" << u.password_.clave() << "] " << u.nombre() << " " << u.apellidos() << endl;
  os << u.direccion() << endl;
  os << "Tarjetas:" << endl;
  for(Usuario::Tarjetas::const_iterator it = u.tarjetas().begin(); it != u.tarjetas().end(); ++it)
    os << *(it->second) ;
  
  os << endl;

  return os;
}


void mostrar_carro (std::ostream& os, const Usuario& u)
{
  os << "Carrito de compra de " << u.id() << " [Artículos: " << u.n_articulos() << "]" << endl;
  os << "Cant. " << "Artículo" << endl;
  os << setfill ('=') << setw(60) << "\n";
  
  /*setfill(): son los caracteres de rellenos que colocamos
    setw(2) << horas: equivaldría a decir que la variable horas serán 2 carácteres*/

  for(Articulos::const_iterator it = u.compra().begin(); it != u.compra().end(); ++it)
    {
      os << "  " << setfill(' ') << it->second << "   ";
      os << "[" << it->first->referencia() << "] \"" << it->first->titulo() << "\", " << it->first->f_publi().anno() << ". " << setiosflags(ios_base::fixed) << setprecision(2) << it->first->precio() << "€" << endl; 
    }

  os << endl;
}


/*Implementación de la clase Clave*/

bool Clave::verifica(const char* c) const
{
  return (Cadena(crypt(c,clave_.subcadena(0,2).c_str())) == clave_);
}


Clave::Clave(const char* c) throw(Clave::Incorrecta)
{
  Cadena cad_(c);
  Cadena salt_("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");

  if(cad_.longitud() < 5)
    throw Clave::Incorrecta(Clave::Razon(CORTA));

  /*Explicación: http://www.gnu.org/s/hello/manual/libc/crypt.html */
 
  cad_ = crypt(cad_.c_str(),salt_.c_str());

  if(cad_.c_str() == NULL)
    throw Clave::Incorrecta(Clave::Razon(ERROR_CRYPT));

  clave_ = cad_;
}
