#include "fecha.h"
#include <iostream>
#include <cstdio>
#include <ctime>
#include <locale.h>


using namespace std;

const int Fecha::AnnoMinimo=1600;
const int Fecha::AnnoMaximo=2200;
const int Fecha::meses[12]={31,28,31,30,31,30,31,31,30,31,30,31};
const char* diasem[]={"domingo","lunes","martes","miercoles","jueves","viernes","sabado"};
const char* nombre_meses[]={"enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"};


Fecha::Fecha (int d,int m,int a) throw(Fecha::Invalida)
{
  time_t t = time(0); //Hora del sistema
  struct tm* fech = localtime(&t); //Conversión del tipo time_t al tipo struct tm

  d==0?dia_=fech->tm_mday:dia_=d;
  m==0?mes_=fech->tm_mon+1:mes_=m;
  a==0?anno_=fech->tm_year+1900:anno_=a;

  verificar_fecha(); //Comprobamos que no se haya liado parda
}

Fecha::Fecha(const Fecha& f)
{
  dia_ = f.dia_;
  mes_ = f.mes_;
  anno_ = f.anno_;
}

Fecha::Fecha(const char* cad) throw(Fecha::Invalida)
{
  time_t t = time(0);
  struct tm* fech = localtime(&t);

  int j=sscanf(cad,"%2d/%2d/%4d",&dia_,&mes_,&anno_);
  
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
  else if (dia_==29 && mes_==2 && !(bisiesto()))
    {
      dia_=1;
      mes_=3;
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
      mes_=2;
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

Fecha& Fecha::operator +=(const int& n)
{
  *this=*this+n;
  verificar_fecha();
  return *this;
}

Fecha& Fecha::operator -=(const int& n)
{
  for(int i=0; i < n; i++)
    --(*this);
  verificar_fecha();
  return *this;
}

Fecha operator +(const Fecha& f, const int& n)
{
  int d = f.dia_ + n ;
  struct tm  tiempo = {0,0,0,d,f.mes_-1,f.anno_-1900,0,0,-1};
  mktime(&tiempo);
  return Fecha(tiempo.tm_mday,tiempo.tm_mon+1,tiempo.tm_year + 1900);
}

Fecha operator -(const Fecha& f, const int& n)
{
  int d = f.dia_ - n ;
  struct tm  tiempo = {0,0,0,d,f.mes_-1,f.anno_-1900,0,0,-1};
  mktime(&tiempo);
  return Fecha(tiempo.tm_mday,tiempo.tm_mon+1,tiempo.tm_year + 1900);
}

Fecha operator +(const int& n, const Fecha& f)
{
  return Fecha(f+n);
}

bool operator ==(const Fecha& f, const Fecha& g)
{
  return (f.dia_ == g.dia_ && f.mes_ == g.mes_ && f.anno_ == g.anno_);
}

bool operator <(const Fecha& f, const Fecha& g)
{ 
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

}

bool operator >(const Fecha& f, const Fecha& g)
{
  if(f.anno() > g.anno()) {
    return true;
  } else if(f.anno() == g.anno()) {
    if(f.mes() > g.mes()) {
      return true;
    } else if(f.mes() == g.mes() && f.dia() > g.dia()) {
      return true;                 
    }
  }
  return false;

}

bool operator >=(const Fecha& f, const Fecha& g)
{
  if(f.anno() > g.anno()) {
    return true;
  } else if(f.anno() == g.anno()) {
    if(f.mes() > g.mes()) {
      return true;
    } else if(f.mes() == g.mes() && f.dia() >= g.dia()) {
      return true;                 
    }
  }
  return false;

}

bool operator <=(const Fecha& f, const Fecha& g)
{
  if(f.anno() < g.anno()) {
    return true;
  } else if(f.anno() == g.anno()) {
    if(f.mes() < g.mes()) {
      return true;
    } else if(f.mes() == g.mes() && f.dia() <= g.dia()) {
      return true;                 
    }
  }
  return false;
}

bool operator !=(const Fecha& f, const Fecha& g)
{
  return !(f==g);
}

int Fecha::dia() const
{
  return dia_;
}

int Fecha::mes() const
{
  return mes_;
}

int Fecha::anno() const
{
  return anno_;
}

Fecha::operator const char*() const
{
  char* cadena=new char[30];
  tm fech = {0, 0, 0,dia_,mes_-1,anno_-1900, 0, 0, -1};
  mktime(&fech);
  //strftime(cadena,30,"%A %d de %B de %Y",&fech);
  sprintf(cadena, "%s %d de %s de %d", diasem[fech.tm_wday], dia_, nombre_meses[mes_-1], anno_);
  return cadena;
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

/*ostream& operator <<(ostream& os, const Fecha& f)
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
  }*/
