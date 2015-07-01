#ifndef _ARTICULO_
#define _ARTICULO_

#include "cadena.h"
#include "fecha.h"
#include "usuario.h"
#include "autor.h"
#include <iostream>
#include <map>
#include <iomanip>

class Articulo
{
public:

  //Clase de excepción
  class Autores_vacios{
  public:
    Autores_vacios():razon_("Sin autores."){}
    Cadena mostrar(){return razon_;}
  private:
    Cadena razon_;
  };

  typedef std::set<Autor*> Autores;

  // Método observador que nos devuelve la referencia de los autores
  Autores autores() const throw() {return autores_;}
  
  //Métodos observadores
  Cadena referencia() const throw() {return cod_ref_; }
  Cadena titulo() const throw() {return titulo_;}
  Fecha f_publi() const throw() {return fech_publi_;}
  double precio() const throw() {return precio_actual_;}
  
  //Métodos modificadores
  double& precio() throw() {return precio_actual_;}

  
  //Constructores

  explicit Articulo(Autores& autores, const Cadena& c, const Cadena& t, const Fecha& f, const double& p) throw(Autores_vacios): autores_(autores), cod_ref_(c), titulo_(t), fech_publi_(f), precio_actual_(p)
  {
    if(autores_.empty()) throw Autores_vacios();
  }

  //Método virtual puro que hace que la clase sea clase abstracta

  virtual void imp_esp(ostream&) const=0;

  //Destructor (se declara también virtual)

  virtual ~Articulo(){};

private:
  typedef std::map<Usuario*,unsigned> Usuarios;
  Autores autores_;
  Cadena cod_ref_;
  Cadena titulo_;
  Fecha fech_publi_;
  double precio_actual_;
  Usuarios usuarios;
};

std::ostream& operator <<(std::ostream& os, const Articulo& a);

/*
  Flujo de salida sera de la forma siguiente:

  [110] "Fundamentos de C++", 1998. 29.95€ 
*/


//Clase Articulos Almacenables

class ArticuloAlmacenable:public Articulo
{
public:
  ArticuloAlmacenable(Autores& autores, const Cadena& c, const Cadena& t, const Fecha& f, const double& p, unsigned stock) throw(Autores_vacios) :Articulo::Articulo(autores,c,t,f,p),stock_(stock){}
  unsigned stock() const {return stock_;}
  unsigned& stock() {return stock_;}
protected:
  unsigned stock_;
};


class Libro: public ArticuloAlmacenable
{
public:
  Libro(Autores& autores, const Cadena& c, const Cadena& t, const Fecha& f, const double& p, unsigned paginas, unsigned stock) throw(Autores_vacios) :ArticuloAlmacenable(autores,c,t,f,p,stock), paginas_(paginas){}
  unsigned n_pag() const {return paginas_;}
  virtual void imp_esp(std::ostream& os) const;
private:
  unsigned paginas_;
};

class Cederron: public ArticuloAlmacenable
{
public:
  Cederron(Autores& autores, const Cadena& c, const Cadena& t, const Fecha& f, const double& p, unsigned tama, unsigned stock) throw(Autores_vacios):ArticuloAlmacenable(autores,c,t,f,p,stock), tam_(tama){}
  virtual void imp_esp(std::ostream& os) const;
  unsigned tam() const { return tam_;}
private:
  unsigned tam_;
};

class InformeDigital: public Articulo
{
public:
  InformeDigital(Autores& autores, const Cadena& c, const Cadena& t, const Fecha& f, const double& p, const Fecha& f_expiracion) throw (Autores_vacios): Articulo::Articulo(autores,c,t,f,p), f_expir_(f_expiracion){}
  Fecha f_expir() const { return f_expir_;}
  virtual void imp_esp(std::ostream& os) const;
private:
  Fecha f_expir_;
  
};


#endif
