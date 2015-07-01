#include "fecha.h"
#include <iostream>
#include <cstdio>
#include <ctime>
#include <cstring>
#include <locale.h>


using namespace std;

locale mi_localidad("");

const int Fecha::AnnoMinimo=1600;
const int Fecha::AnnoMaximo=2200;
const static int meses[12]={31,28,31,30,31,30,31,31,30,31,30,31};

Fecha::Fecha (int d,int m,int a) throw(Fecha::Invalida)
{
  time_t t = time(0); //Hora del sistema
  tm* fech = localtime(&t); //Conversión del tipo time_t al tipo struct tm
 
  dia_ = d == 0 ? fech->tm_mday : d;  
  //Al hacer la comprobación asigna 1 de los 2 valores válidos 0: fech 1:d

  mes_ = m == 0? fech->tm_mon+1: m;

  anno_ = a == 0? fech->tm_year+1900: a;

  verificar_fecha(); //Comprobamos que no se haya liado parda
}

Fecha::Fecha(const char* cad) throw(Fecha::Invalida)
{
  time_t t = time(0);
  struct tm* fech = localtime(&t);

  int j=sscanf(cad,"%d/%d/%d",&dia_,&mes_,&anno_);
  
  if(j!=3)
    throw Invalida("Fecha Incorrecta");

  if(dia_ == 0)
    dia_ = fech->tm_mday;

  if(mes_ == 0)
    mes_ = fech->tm_mon+1;

  if(anno_ == 0)
    anno_ = fech->tm_year+1900;

  verificar_fecha();
}

Fecha& Fecha::operator ++() 
{
  if(dia_==28 && mes_==2 && bisiesto())
      dia_++;
  else if (dia_==29 && mes_==2 && bisiesto())
    {
      dia_=1;
      mes_++;
    }
  else if (dia_==31 && mes_==12)
    {
      dia_=1;
      mes_=1;
      anno_++;
    }
  else if(dia_== meses[mes_-1])
    {
      dia_=1;
      mes_++;
    }
  else
    dia_++;
    
  return *this;
}

Fecha Fecha::operator ++(int) 
{
  Fecha f(*this);
  ++(*this);
  return f;
}

Fecha& Fecha::operator --() 
{
  if(dia_==1 && mes_==3 && bisiesto())
    {
      dia_=29;
      mes_--;
    }
  else if(dia_==1 && mes_==1)
    {
      dia_=31;
      mes_=12;
      anno_--;
    }
  else if(dia_==1)
    {
      mes_--;
      dia_= meses[mes_-1];
    }
  else
    dia_--;

  return *this;
}

Fecha Fecha::operator --(int) 
{
  Fecha f(*this);
  --(*this);
  return f;
}

Fecha& Fecha::operator +=(int n) 
{
  *this=*this+n;
  verificar_fecha();
  return *this;
}

Fecha& Fecha::operator -=(int n) 
{
  for(int i=0; i < n; i++)
    --(*this);
  verificar_fecha();
  return *this;
}

Fecha operator +(const Fecha& f, int n)
{
  int d = f.dia_ + n ;
  struct tm  tiempo = {0,0,0,d,f.mes_-1,f.anno_-1900,0,0,-1};
  mktime(&tiempo);
  return Fecha(tiempo.tm_mday,tiempo.tm_mon+1,tiempo.tm_year + 1900);
}

Fecha operator -(const Fecha& f, int n)
{
  int d = f.dia_ - n ;
  struct tm  tiempo = {0,0,0,d,f.mes_-1,f.anno_-1900,0,0,-1};
  mktime(&tiempo);
  return Fecha(tiempo.tm_mday,tiempo.tm_mon+1,tiempo.tm_year + 1900);
}

bool operator ==(const Fecha& f, const Fecha& g) throw()
{
  return (f.dia() == g.dia() && f.mes() == g.mes() && f.anno() == g.anno());
}

bool operator <(const Fecha& f, const Fecha& g) throw()
{ 
  long aux_1 = f.anno()*10000 + f.mes()*100 + f.dia();
  long aux_2 = g.anno()*10000 + g.mes()*100 + g.dia();

  return (aux_1 < aux_2);
  
  /*
  if(f.anno() < g.anno()) {
    return true;
  } else if(f.anno() == g.anno()) {
    if(f.mes() < g.mes()) {
      return true;
    } else if(f.mes() == g.mes() && f.dia() < g.dia()) {
      return true;                 
    }
  }
  return false;
  */
}

bool operator >(const Fecha& f, const Fecha& g) throw()
{ 
  return !(f < g || f == g);
}

bool operator >=(const Fecha& f, const Fecha& g) throw()
{
  return (f > g || f == g);
}

bool operator <=(const Fecha& f, const Fecha& g) throw()
{
  return (f < g || f == g);
}

bool operator !=(const Fecha& f, const Fecha& g) throw()
{
  return !(f==g);
}

int Fecha::dia() const throw()
{
  return dia_;
}

int Fecha::mes() const throw()
{
  return mes_;
}

int Fecha::anno() const throw()
{
  return anno_;
}

const char* Fecha::cadena() const throw()
{
  locale::global(mi_localidad);
  static char c[35];
  tm fecha = {0, 0, 0,dia_,mes_-1,anno_-1900, 0, 0, -1};
  mktime(&fecha);
  strftime(c,35,"%A %d de %B de %Y",&fecha);
  return c;
}

void Fecha::verificar_fecha() const throw(Fecha::Invalida)
{
  if(anno_<AnnoMinimo || anno_ > AnnoMaximo)
    throw Fecha::Invalida("Error: año inválido");
  if(mes_>12 || mes_<1)
    throw Fecha::Invalida("Error: mes inválido");
  if(dia_>meses[mes_-1] && mes_!=2 && !bisiesto())
    throw Fecha::Invalida("Error: dia del mes inválido");

}

//Operadores de insercción y extracción

ostream& operator <<(ostream& os, const Fecha& f)
{
  os << f.cadena();
  return os;
}

istream& operator >>(istream& is, Fecha& f) throw(Fecha::Invalida)
{
  char aux[11];
  is.width(11);
  is >> aux;
  f=Fecha(aux);

  return is;
}
