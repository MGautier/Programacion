#!/usr/bin/perl

use strict;

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 1 - Ejercicio 1

my $texto;

# Pongo el valor del rand mas 1 porque el da valores de 0-99 en este caso, asi que yo lo establezco
# en una cota 1 por encima.

my $num = int(rand(100))+1;
my $contador = 9;

print "¡Esto es un juego de azar! Introduzca un número y gane un premio.\n";
while($contador > 0){
		chomp;
		$texto = <>;
		

		if($texto < $num)
		{
			print "El valor introducido es menor que el número premio \n";
		}
		else
		{
			if($texto > $num)
			{
				print "El valor introducido es mayor que el número premio \n";
			}
			else
			{
				print "¡Te ha tocado la lotería! \n";
				exit(1);
			}
		}
		$contador--;
	}

if($contador == 0)
{
	print "¡Pillín, lo has hecho 10 veces! \n";
}

