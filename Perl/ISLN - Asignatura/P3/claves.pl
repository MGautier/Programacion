#!/usr/bin/perl

use strict;
use XML::Simple;
use XML::LibXML;
use utf8;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 3 - Ejercicio 1

my $fuente = XML::LibXML->new(); #Creamos una instancia de la biblioteca LibXML

my $xml = $fuente->parse_file("sara.xml"); #Parseamos el documento xml a un formato manejable en perl

my %hash;
my $clave;




for my $etiqueta ( $xml->findnodes('/aiml/category') ) 
{
    my $valores = [];
    my ($pattern) = $etiqueta->findnodes('./pattern');
    #print "Mi pattern es: ", $pattern->to_literal, "\n";
    $clave = $pattern->to_literal; #Aquí almaceno mi clave del hash que sera el pattern
    $clave =~ tr/\[ÁÉÍÓÚÜÑÇ]/[áéíóúüñç]/;
    $clave =~ tr/\A-Z/a-z/;
    my ($template) = $etiqueta->findnodes('./template');
    #print "Literal", $aux, "\n";
    my ($random) = $template->findnodes('./random');
    #print "Random", $random, "\n";
    for my $answers ( $random->findnodes('./li') )
    {
	if($answers =~ /<star.*?>/) 
	{
	    $answers =~ s/<star\/>/RIGHT/g;
	    $answers =~ s/<star index="1"\/>/LEFT/g;
	    $answers =~ s/<star index="2"\/>/RIGHT/g;
	    $answers =~ s/<li>/ /g;
	    $answers =~ s/<\/li>/ /g;
	    print "Li: ", $answers, "\n";
	    
	}

	push(@$valores,$answers);
    }
    
    $hash{$clave} = $valores;

}

foreach my $key (sort keys %hash)
{
    print "Claves: $key \n";
}
