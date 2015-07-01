package bd;
use strict;
use utf8;
use warnings;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 4 - Ejercicio 2 [modulo base de datos]



BEGIN
{
    require Exporter;
    
    our $VERSION = 1.00;
    
    our @ISA= qw( Exporter );
    
    our @EXPORT = qw( bd_crear bd_consultar bd_actualizar bd_leer bd_borrar ); #Funciones y variables que se exportaran por defecto
    
    our @EXPORT_OK = qw(  ); #Funciones y vaiables que se exportaran opcionalmente
    
}

# Variables publicas

# Variables privadas

sub bd_crear
{
   my ($nombre,%hash) = @_;

   die "No se encuentra la DBM con ese nombre.\n" unless $nombre;
   dbmopen(%hash,$nombre,0666);
   dbmclose(%hash);
}

sub bd_borrar
{
   my ($nombre) = @_;

   die "No se encuentra la DBM con ese nombre.\n" unless $nombre;
   unlink("$nombre.dir");
   unlink("$nombre.pag");
}

sub bd_consultar
{
   my ($nombre, $key) = @_;
   my %hash;
   my $resultado;
   die "No se encuentra la DBM con ese nombre.\n" unless $nombre;
   die "No se encuentra el valor.\n" unless $key;
   dbmopen(%hash,$nombre,0666);
   if ($hash{$key}) {
      $resultado = $hash{$key};
      print($key, ' = ', $hash{$key}, "\n");
   } else {
      print($key, " = (no definido)\n");
   }
   dbmclose(%hash);
   return $resultado;

}

sub bd_actualizar
{
   my ($nombre,%hash) = @_;
   die "No se encuentra la DBM con ese nombre\n" unless $nombre;
   dbmopen(%hash,$nombre,0666);
   dbmclose(%hash);
}

sub bd_leer
{
   my ($nombre) = @_;
   my %hash;
   die "No se encuentra la DBM con ese nombre.\n" unless $nombre;
   dbmopen(%hash,$nombre,0666);
   while (my ($key,$val)=each(%hash)) {
      print($key, ' = ', $val, "\n");
   }
   dbmclose(%hash);
}

END
{ }

1;

