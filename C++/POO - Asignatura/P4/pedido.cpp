#include <iostream>
#include <iomanip>
#include "pedido.h"

using namespace std;

int Pedido::N_pedidos=0;

std::ostream& operator <<(std::ostream& os, const Pedido& p)
{
  os << endl;
  os << "   Núm. pedido: " << p.numero() << endl;
  
  os << "   Fecha: \t" << (p.fecha()).cadena() << endl;
  os << "   Pagado con:  " << p.tarjeta()->numero() << endl;
  os << "   Importe:     " << (p.total()) << "€" << endl;

  return os;

}

Pedido::Pedido(Usuario_Pedido& u_p, Pedido_Articulo& p_a, Usuario& u, const Tarjeta& t, const Fecha f) throw(Tarjeta::Caducada,Vacio,Impostor,SinStock)
{
  fecha_ = f;
  num_ = N_pedidos+1;
  tarjeta_ = &t;
  total_ = 0.0;

  if(t.caducidad() < f)
    throw Tarjeta::Caducada(f);

  if((u.compra()).empty())
    throw Pedido::Vacio(u);

  if(t.titular() != &u)
    throw Pedido::Impostor(u);

  for(Articulos::const_iterator i= (u.compra()).begin(); i != (u.compra()).end(); ++i)
    {
      if(ArticuloAlmacenable* pArticulo = dynamic_cast<ArticuloAlmacenable*>(i->first))
      //Comprobamos si no hay suficiente stock para los artículos a comprar
	if(pArticulo->stock() < (i->second))
	  {
	    Articulo* articu_ = i->first;
	    
	    for(Articulos::const_iterator j = (u.compra()).begin(); j != (u.compra()).end(); ++j)
	      {
		u.compra(*(j->first),0);
		//Vacíamos el carrito de la compra
	      }
	    throw SinStock(*articu_); //Anulamos el pedido
	    
	  }
    }

  u_p.asocia(*this,u); //Nuevo pedido asociado al usuario
  bool out=true; //Para comprobar si el pedido queda vacio o no

  for(Articulos::const_iterator i = (u.compra()).begin(); i != (u.compra()).end(); ++i)
    {

      if(ArticuloAlmacenable* pArticulo = dynamic_cast<ArticuloAlmacenable*>(i->first))
	{
	  p_a.pedir(*this,*(i->first),(i->first)->precio(),i->second);
	  
	  total_ += (i->first)->precio()*i->second; 
	  //Vamos almacenando los precios por sus unidades correspondientes

	  u.compra(*(i->first),0); 
	  //Modifica el carrito y lo deja vacío
	  
	  pArticulo->stock() -= (i->second);
	  //Actualizamos el stock de articulos

	  out = false; //El pedido no queda vacio
	}
      else if(InformeDigital* pInforme = dynamic_cast<InformeDigital*>(i->first))
	{
	  if(pInforme->f_expir() > Fecha())
	    {
	      	  p_a.pedir(*this,*(i->first),(i->first)->precio(),i->second);
	  
		  total_ += (i->first)->precio()*i->second; 
		  //Vamos almacenando los precios por sus unidades correspondientes
		  
		  u.compra(*(i->first),0); 
		  //Modifica el carrito y lo deja vacío
		  
		  out = false; //El pedido no queda vacio
		  
	    }
	}
    }
    
  if(out)
    throw Vacio(u);
  
  N_pedidos++;
  //Actualizamos el número de pedidos en el sistema
}
