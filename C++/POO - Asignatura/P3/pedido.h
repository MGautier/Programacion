#ifndef _PEDIDO_
#define _PEDIDO_

#include "tarjeta.h"
#include "usuario.h"
#include "articulo.h"
#include "pedido-articulo.h"
#include "usuario-pedido.h"
#include "fecha.h"
#include "cadena.h"

class Pedido_Articulo;
class Usuario_Pedido;

class Pedido
{
public:

  class Vacio
  {
  public:
    Vacio(Usuario& u):u_(&u){}
    Usuario& usuario() const throw() {return *u_;}
  private:
    Usuario* u_;
  }; //Fin clase excepción Vacio

  class Impostor
  {
  public:
    Impostor(Usuario& u):impostor_(&u){}
    Usuario& usuario() const throw() {return *impostor_;}
  private:
    Usuario* impostor_;
  }; //Fin clase excepción Impostor

  class SinStock
  {
  public:
    SinStock(Articulo& a):sin_stock_(&a){}
    Articulo& articulo() const throw() {return *sin_stock_;}
  private:
    Articulo* sin_stock_;
  }; //Fin clase excepción SinStock

  //Constructor

  Pedido(Usuario_Pedido&, Pedido_Articulo&, Usuario&, const Tarjeta&, const Fecha=Fecha() ) throw (Tarjeta::Caducada,Pedido::Vacio,Pedido::Impostor,Pedido::SinStock);

  //Métodos Observadores

  int numero() const throw() {return num_;}
  const Tarjeta* tarjeta() const throw() {return tarjeta_;}
  Fecha fecha() const throw() {return fecha_;}
  double total() const throw() {return total_;}
  static int n_total_pedidos() throw() {return N_pedidos;}

  //Métodos Modificadores
  
private:

  static int N_pedidos;
  int num_;
  const Tarjeta* tarjeta_;
  Fecha fecha_;
  double total_;

};

std::ostream& operator <<(std::ostream& os, const Pedido& p);
/*
  Núm. pedido: 1
  Fecha:       martes 10 de marzo de 2009
  Pagado con:  4539451203987356
  Importe:     149.95€

 */
 
#endif
