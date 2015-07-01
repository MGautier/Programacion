#include <iostream>
#include <iomanip>
#include "pedido-articulo.h"
#include "tarjeta.h"
#include "articulo.h"

/*Implementación clase LineaPedido */

std::ostream& operator << (std::ostream& os, const LineaPedido& l_p)
{
  os << setiosflags(ios_base::fixed) << setprecision(2) << l_p.precio_venta() << "€\t" << l_p.cantidad();

  return os;
}

/* Implementación clase objeto OrdenaPedidos */

bool OrdenaPedidos::operator() (const Pedido* p1, const Pedido* p2) const
{
  return p1->numero() < p2->numero();
}

/* Implementación clase objeto OrdenaArticulos */

bool OrdenaArticulos::operator() (const Articulo* a1, const Articulo* a2) const
{
  return a1->referencia() < a2->referencia();
}

/* Implementación clase Pedido_Articulo */

void Pedido_Articulo::pedir(Pedido& p, Articulo& a, double prec, int cant) throw()
{
  LineaPedido l(prec,cant);
  PA_[&p].insert(std::make_pair(&a,l));
  AP_[&a].insert(std::make_pair(&p,l));
}

void Pedido_Articulo::pedir(Articulo& a, Pedido& p, double prec, int cant) throw()
{
  pedir(p,a,prec,cant);
}

Pedido_Articulo::ItemsPedido& Pedido_Articulo::detalle(Pedido& p) throw()
{
  return (PA_[&p]);
}

Pedido_Articulo::Pedidos& Pedido_Articulo::ventas(Articulo& a) throw()
{
  return (AP_[&a]);
}

void Pedido_Articulo::mostrarDetallePedidos(std::ostream& os) throw()
{
  double auxiliar=0.0;

  for(Pedido_a_Articulo::const_iterator i = PA_.begin(); i != PA_.end(); ++i)
    {
	 os << "Pedido núm. " << i->first->numero() << endl
	 << "Cliente: " << i->first->tarjeta()->titular()->id() //Datos del cliente, en este caso el id
	 << "\t\tFecha: " << i->first->fecha().cadena() << endl
	 << i->second << endl; //El listado de items
      
      auxiliar += i->first->total();
    }

  os << "TOTAL VENTAS: " << auxiliar << "€" << endl; //Coste total de los articulos
}

void Pedido_Articulo::mostrarVentasArticulos(std::ostream& os) throw()
{
  for(Articulo_a_Pedido::const_iterator i=AP_.begin(); i != AP_.end(); ++i)
    {
      os << "Ventas de [" << i->first->referencia() << "]" 
	 << " \"" << i->first->titulo() << "\" " << i->second << endl;
    }
}

std::ostream& operator << (std::ostream& os, const Pedido_Articulo::ItemsPedido& ip)
{
  os << setfill ('=') << setw (67) << "\n" << setfill(' ');
  os << "  PVP \t  Cant. \tArtículo" << endl;
  os << setfill ('=') << setw (67) << "\n" << setfill(' ');

  double total;
  for (Pedido_Articulo::ItemsPedido::const_iterator i = ip.begin(); i != ip.end(); ++i){
    os <<  i->second.precio_venta() << "€\t" << i->second.cantidad()
       << "\t[" << i->first->referencia() << "]"
       << "\"" << i->first->titulo() << "\"" << endl;
    
    total +=i->second.precio_venta()* i->second.cantidad();
  }

   os << setfill ('=') << setw (67) << "\n" << setfill(' ');

  os<< "Total\t" << total <<"€" << endl;
  return os;

}

std::ostream& operator << (std::ostream& os, const Pedido_Articulo::Pedidos& p)
{
  os << setprecision(2) << fixed << "[Pedidos " << p.size() << "]" << endl;
  os << setfill ('=') << setw (67) << "\n" << setfill(' ');
  os << "  PVP\tCant.\tFecha venta" << endl;
  os << setfill ('=') << setw (67) << "\n" << setfill(' ');
  
  double precio=0.0;
  int cantidad=0;

  for(Pedido_Articulo::Pedidos::const_iterator it=p.begin();it!=p.end();it++)
    {
      os << setprecision(2) << it->second.precio_venta() <<"€\t" 
	 << it->second.cantidad() << "\t" << it->first->fecha() << endl;
      
      precio+= it->second.precio_venta()* it->second.cantidad();
      cantidad+= it->second.cantidad();

    }

  os<< setfill ('=') << setw (67) << "\n" << setfill(' ');
    
  os << setprecision(2) << precio << "€   " << cantidad << endl;

  return os;


}

