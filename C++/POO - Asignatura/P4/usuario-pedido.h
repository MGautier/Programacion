#ifndef _USUARIO_PEDIDO_
#define _USUARIO_PEDIDO_

#include <map>
#include <set>
#include <iostream>
#include "usuario.h"
#include "pedido.h"

class Pedido;

class Usuario_Pedido
{
 public:
  typedef std::set<Pedido*> Pedidos;
  typedef std::map<Usuario*,Pedidos> Usuario_a_Pedido;
  typedef std::map<Pedido*,Usuario*> Pedido_a_Usuario;

  void asocia (Usuario& u, Pedido& p) 
  {
    UP_[&u].insert(&p);
    PU_[&p] = &u;
  }
  
  void asocia (Pedido& p, Usuario& u) 
  {
    asocia(u,p);
  }
  
  Pedidos& pedidos(Usuario& u) 
  {
    return UP_ [&u];
  }
  
  Usuario* cliente(Pedido& p) 
  {
    return PU_ [&p];
  }
  
 private:
  Usuario_a_Pedido UP_;
  Pedido_a_Usuario PU_;
};

#endif
