#ifndef _PEDIDO_ARTICULO_
#define _PEDIDO_ARTICULO_

#include "pedido.h"

class Pedido;

class LineaPedido
{
public:
  //Constructor
  explicit LineaPedido(double precio, unsigned cant=1):precio_venta_(precio),cantidad_(cant) {}

  //Métodos observadores
  double precio_venta() const throw() {return precio_venta_;}
  unsigned cantidad() const throw() {return cantidad_;}
private:
  double precio_venta_;
  unsigned cantidad_;
};

/* Se imprimirá en el flujo de salida:
   Precio de venta (2 decimales) € \t y la cantidad */

std::ostream& operator << (std::ostream& os, const LineaPedido& l_p);

class OrdenaPedidos
{
  //Ordena los pedidos ascendentemente por número
public:
  bool operator() (const Pedido*, const Pedido*) const;
};

class OrdenaArticulos
{
  //Ordena los artículos ascendentemente por referencia

public:
  bool operator() (const Articulo*, const Articulo*) const;
};

class Pedido_Articulo
{
public:

  typedef std::map<Articulo*, LineaPedido, OrdenaArticulos> ItemsPedido;
  typedef std::map<Pedido*, LineaPedido, OrdenaPedidos> Pedidos;
  typedef std::map<Pedido*, ItemsPedido, OrdenaPedidos> Pedido_a_Articulo; //Pedido->Articulo
  typedef std::map<Articulo*, Pedidos, OrdenaArticulos> Articulo_a_Pedido; //Articulo->Pedido

  //Métodos modificadores
  /* Para la creación de enlaces entre pedidos y artículos */
  void pedir(Pedido&, Articulo&, double, int=1) throw();
  void pedir(Articulo&, Pedido&, double, int=1) throw();

  //Métodos observadores

  ItemsPedido& detalle(Pedido&) throw();
  /* Devolerá la colección de artículos de un pedido junto a su precio de venta
     y cantidad comprada */

  Pedidos& ventas(Articulo&) throw();
  /* Devolverá todos los pedidos de un artículo con precio de venta
     y cantidad */

  void mostrarDetallePedidos(std::ostream& os) throw();
  /* Imprimirá el detalle de todos los pedidos realizados hasta la fecha */

  void mostrarVentasArticulos(std::ostream& os) throw();
  /* Imprimirá todas las ventas agrupadas por artículos */


private:
 
  Pedido_a_Articulo PA_;
  Articulo_a_Pedido AP_;

};

std::ostream& operator << (std::ostream& os, const Pedido_Articulo::ItemsPedido& items);

std::ostream& operator << (std::ostream& os, const Pedido_Articulo::Pedidos& pedi);


#endif
