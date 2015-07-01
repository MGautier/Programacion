#ifndef _USUARIO_
#define _USUARIO_

#include <iostream>
#include <map>
#include <set>
#include "cadena.h"


class Tarjeta;
class Articulo;
class Numero;

typedef std::map<Articulo*, unsigned> Articulos;

class Clave
{
private:
  Cadena clave_;
public:
  enum Razon {CORTA,ERROR_CRYPT};
  class Incorrecta{
  private:
    Clave::Razon r_;
  public:
    Incorrecta(const Clave::Razon r):r_(r) {}
    Clave::Razon razon() const {return r_;}
  };//Fin Clase excepción Incorrecta
  Cadena clave() const {return clave_;}
  bool verifica(const char*) const;
  Clave(const char*) throw(Clave::Incorrecta);
  
  
};//Fin Clase Clave

class Usuario{

 public:

  typedef  std::map<Numero, Tarjeta*> Tarjetas;

  class Id_duplicado{
    
  public:
    Id_duplicado(const Cadena& car_):id_dupli_(car_) {}
    Cadena idd() const {return id_dupli_;}
  private:
    Cadena id_dupli_;

  };//Fin Clase excepción Id_duplicado

  void es_titular_de(Tarjeta &) throw(); //void asocia (B&); 1-1
  void no_es_titular_de(Tarjeta &) throw(); //void asocia (B&); 1-1

  //Métodos Observadores

  Cadena id() const throw();
  Cadena nombre() const throw();
  Cadena apellidos() const throw();
  Cadena direccion() const throw();
  const Tarjetas& tarjetas() const throw(); //const B& asocia() const; 1-1
  const Articulos& compra() const throw(); //const Bs& asocia() const; *-*
  size_t n_articulos() const throw();

  //Método Modificador

  void compra(Articulo &, unsigned=1) throw(); //void asocia (B&,c); *-*

  explicit Usuario(const Cadena&, const Cadena&, const Cadena&, const Cadena&, const Clave& key) throw(Usuario::Id_duplicado);

  ~Usuario();

  friend std::ostream& operator <<(std::ostream& os, const Usuario& u);
  /*
    Flujo de salida sera de la forma siguiente:
    
    identificador [clave cifrada] nombre apellidos
    dirección
    Tarjetas:
    <lista de tarjetas>
  */


 private:
  Cadena identificador_, nombre_, apellidos_, direccion_;
  Clave password_;
  Tarjetas tarjetas_; //B* b; 1-1
  Articulos articulos_; //Bs bs; *-*

  //Conjunto para evitar identificadores duplicados

  static std::set<Cadena> conj_ids;

  //ESTOS METODOS NO SE PUEDEN USAR
  Usuario(const Usuario&); //Constructor de Copia
  Usuario& operator = (const Usuario&); //Operador de asignación
  /*----------------------------------*/

};//Fin clase Usuario

void mostrar_carro(std::ostream&, const Usuario& u);

/*mostrar_carro() deberá mostrar o imprimir el contenido del carro de compra de un usuario en un flujo de salida con el formato del ejemplo

Carrito de compra de lucas [Artículos: 2]
 Cant. Artículo

=============================================================

   1   [111] "The Standard Template Library", 2002.  42.10€
   3   [110] "Fundamentos de C++", 1998.  35.95€
*/

#endif
