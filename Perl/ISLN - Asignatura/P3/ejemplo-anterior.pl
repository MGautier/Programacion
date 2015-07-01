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



while(<>)
{

    chomp;
    
    $cadena = $_;
    $cadena =~ s/[!?¿¡,;:]//sg;
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

    #Almaceno en el array @texto la entada estandar en formato de lista
    
    @texto = split(/\s+/, $cadena); #Aquí lo que hacemos es transformar el string a elementos del array
    
    $contador = -1;
    foreach my $key (@texto)
    {
	$contador++;
	print "$key \n";
	if($key =~ /^es$/g && $output == 1)
	{
	    if($contador > 0)
	    {
		my $size = @{$hash{'* es *'}};
		my $elto = int(rand($size));
		#print "Mi array tiene una dimension de: $size \n";
		#print "Mi indice antes del if es: $elto \n";
		if($elto == '1' || $elto == '2' || $elto == '3' || $elto == '4' || $elto == '5')
		{
		    my @subcadena = split(/\s+/,$hash{'* es *'}[$elto]); #Convierto el string en un array en donde cada componente es una parte del string original

		    # Prefiero hacerlo recorriendo las posiciones del array y no sirviendo la informacion yo manualmente en un print porque si cambia el contenido para dicho esquema xml
		    # con cambiar los valores o las claves de los indices del array ya seria suficiente dado que el esquema vendria a ser igual para todos.
		    
		    print "Sara > ";
		    foreach my $value (@subcadena)
		    {

			if($value =~ /^es$/g)
			{
			    print "$texto[$contador-1] ", "$value ", "$texto[$contador+1]";
			}
			else
			{
			    print "$value ";
			}

		    }
		    print "\n";
		}
		else
		{
		    #print "Mi indice es: $elto y mi contenido es: ","$hash{'* es *'}[$elto] \n";
		    print "Sara > ";
		    print "$hash{'* es *'}[$elto] \n";
		}
	    }
	    print "Yo > ";
	    $output = 0;
	}

	if($key =~ /^gusta$/g && $output == 1)
	{
	    if($texto[$contador-1] =~ /^te$/g)
	    {
		#print "TE GUSTA";
		my $aux; #Con esta variable voy recorriendo el array @texto para extraer la información que sigue a la clave "te gusta"
		$aux = $contador;
		my $opcion = int(rand(2)); #Alterno entre la opcion te gusta * y * te gusta *, ya que ambas tienen la misma estructura.
		my $size;
		my @subcadena;
		my $elto;
		if($opcion)
		{
		    $size = @{$hash{'* te gusta *'}};
		    $elto = int(rand($size));
		    @subcadena = split(/\s+/,$hash{'* te gusta *'}[$elto]); #Convierto el string en un array en donde cada componente es una parte del string original
		}
		else
		{
		    $size = @{$hash{'te gusta *'}};
		    $elto = int(rand($size));
		    @subcadena = split(/\s+/,$hash{'te gusta *'}[$elto]); #Convierto el string en un array en donde cada componente es una parte del string original
		}

		#print "Te gusta : ";

		if($elto == '0' || $elto == '2')
		{
		    

		    # Prefiero hacerlo recorriendo las posiciones del array y no sirviendo la informacion yo manualmente en un print porque si cambia el contenido para dicho esquema xml
		    # con cambiar los valores o las claves de los indices del array ya seria suficiente dado que el esquema vendria a ser igual para todos.
		    
		    print "Sara > ";
		    foreach my $value (@subcadena)
		    {

			if($value =~ /^gusta$/g)
			{
			    print "$value ";
			    $aux++; # Preincremento aux para que extraiga directamente la siguiente posicion en la que se encuentra actualmente
			    while((scalar @texto) > $aux)
			    {
				print "$texto[$aux] ";
				$aux++;
			    }
			    
			}
			else
			{
			    print "$value ";
			}

		    }
		    print "\n";
		}
		else
		{
		    #print "Mi indice es: $elto y mi contenido es: ","$hash{'* es *'}[$elto] \n";
		    print "Sara > ";
		    if($opcion)
		    {
			print "$hash{'* te gusta *'}[$elto] \n";
		    }
		    else
		    {
			print "$hash{'te gusta *'}[$elto] \n";
		    }
		}
	    }
	    print "Yo > ";
	    $output = 0;
	}

	#Extraigo los elementos del array y voy comparandolos con las palabras
	#claves del ejercicio.

	#Ahora voy comparando el elemento anterior con cada palabra 
	# clave de mi ejercicio y si hace match, compruebo que no se
	# ha repetido y si no es asi, la introduzco en claves_generadas
	# que sera la cadena salida segun los datos que reciba.

	if($hash{$key} && $output == 1)
	{
	    my $size = @{$hash{$key}};
	    my $elto = rand($size);
	    #print "Mi dimension de array es: $size \n";
	    print "Mi clave es $key \n";
	    #print "Mi indice del array es $elto \n";
	    print "Sara > ", $hash{$key}[$elto], "\n";
	    print "Yo > ";
	    $output = 0;
	}
	
    }
}
# Puedo intentar o un hash de arrays o dos hashes que cada uno estén en orden, es decir, para la clave 1 del primer hash este "SARA" y para la clave 1 del segundo hash este la respuesta asociada
