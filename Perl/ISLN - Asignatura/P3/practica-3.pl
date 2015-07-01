#!/usr/bin/perl

use strict;
use XML::Simple;
use XML::LibXML;
use utf8;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";
use parser;

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 3 - Ejercicio 1 [main]

# Ahora voy a pedir de la entrada estandar como si fuera el chat de la practica 1 ejercicio 2

#parser::cambiar_prompt("Moises dice >");

sara();
leer_xml("sara.xml");

my $cadena;
my @texto;
my $contador;
my %hash = hash_return();
my $left;
my $right;


while(<>)
{

    chomp;
    
    $cadena = $_;
    $cadena =~ s/[!?¿¡,;:\.]//sg;
    $cadena =~ tr/\A-Z/a-z/;
    $cadena =~ tr/\Á/á/;
    $cadena =~ tr/\É/é/;
    $cadena =~ tr/\Í/í/;
    $cadena =~ tr/\Ó/ó/;
    $cadena =~ tr/\Ú/ú/;

    my $output; # Uso esta variable para almacenar si hay devuelve un resultado o no por salida estandar
    $output = 1;
    
    if($cadena =~ s/adios//)
    {
	print "Sara > $hash{'adios'}[rand(3)]", "\n";
	exit(1);
    }
    
    foreach my $claves (keys %hash)
    {
	#print "Mi key es: $cadena y mi claves es: $claves \n";
	if($cadena =~ m/$claves/ && $output == 1)
	{
	    $left = $1;
	    $right = $2;
	    if($hash{$claves})
	    {
		my $size = @{$hash{$claves}};
		my $elto = rand($size);
		$hash{$claves}[$elto] =~ s/LEFT/$left/sg;
		
		if($right)
		{
		    $hash{$claves}[$elto] =~ s/RIGHT/$right/sg;
		}
		else
		{
		    $hash{$claves}[$elto] =~ s/RIGHT/$left/sg;
		}
		
		print "Sara > ", $hash{$claves}[$elto], "\n";
		print "Yo > ";
		$output = 0;
	    }
	}
	
    }
    
    if($output == 1)
    {
	print "Sara > Interesante. Cuéntame más. \n";
	print "Yo > ";
    }
}    
