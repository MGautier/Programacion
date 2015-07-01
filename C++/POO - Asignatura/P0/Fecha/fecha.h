#ifndef _FECHA_
#define _FECHA_


#include <cstring>
#include <fstream>
#include <cstdio>

using namespace std;

class Fecha{
 public:

  //Clase Invalida para excepciones
  class Invalida
  {
  public:
    const char* por_que(){return info_;}
  Invalida(const char* porque):info_(porque){}
  private:
    const char* info_;
  };
  
  //CONSTRUCTORES
  explicit Fecha (const int d=0, const int m=0, const int a=0) throw(Fecha::Invalida); //Mas eficiente

  Fecha(const Fecha& f); //Ctor. copia

  Fecha (const char*) throw(Fecha::Invalida); //Cadena caracteres a Fecha
  
  //OPERADORES

  Fecha& operator ++(); //Incremento (fecha incrementada)
  Fecha operator ++(int); //Incremento para un entero razonable (otra fecha que será resultado de la original más el entero)

  Fecha& operator --(); //Decremento (fecha decrementada)
  Fecha operator --(int); //Decremento para un entero razonable (otra fecha que será resultado de la original menos el entero)
  
  Fecha& operator += (const int&); //Incremento con asignación 
  Fecha& operator -= (const int&); //Decremento con asignación

  friend Fecha operator +(const Fecha&, const int&);
  friend Fecha operator -(const Fecha&, const int&);
  friend Fecha operator +(const int&, const Fecha&);

  //friend: El caso más común es la sobrecarga de los operadores aritméticos
  //binarios y de los operadores de inserción y extracción - pag: 196

  friend bool operator ==(const Fecha&, const Fecha&); //Igualdad
  friend bool operator <(const Fecha&, const Fecha&); //Menor
  friend bool operator >(const Fecha&, const Fecha&); //Mayor
  friend bool operator >=(const Fecha&, const Fecha&); //Mayor o igual
  friend bool operator <=(const Fecha&, const Fecha&); //Menor o igual
  friend bool operator !=(const Fecha&, const Fecha&); //Desigualdad


  //METODOS OBSERVADORES
  int dia() const; //Metodo observador
  int mes() const; //Metodo observador
  int anno() const; //Metodo observador

  //Conversión implícita de fecha a cadena
  operator const char*() const;


  
 private:
  int dia_, mes_, anno_;
  static const int AnnoMinimo, AnnoMaximo;
  static const int meses[12];

  bool bisiesto() const{return (anno_ % 4 == 0 && (anno_ % 400 == 0 || anno_ % 100 !=0));}
  //El año es bisiesto si es divisible por 4, excepto si es divisible por 100, 
  //salvo que en este caso lo sea por 400.

  void verificar_fecha() const throw(Fecha::Invalida);
  //Metodo privado para obtener la fecha del sistema cuando
  //no se pase como parámetro de entrada a ningún otro método

};

  //operadores insercción y extracción
//  std::istream& operator >>(std::istream& is,Fecha& f)throw(Fecha::Invalida);
//  std::ostream& operator <<(std::ostream& os, const Fecha& f);

#endif
