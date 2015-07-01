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
	#print "$key \n";
	if($key =~ /^es$/g && $output == 1)
	{
	    if($contador > 0)
	    {
		my $pattern = '* es *';
		introducir_texto(@texto);
		mostrar_mensaje_largo($pattern, $contador);
		$output = 0;
	    }
	}

	if($key =~ /^gusta$/g && $output == 1)
	{
	    if($texto[$contador-1] =~ /te/g)
	    {
		my $opcion = int(rand(2)); #Alterno entre la opcion te gusta * y * te gusta *, ya que ambas tienen la misma estructura.
		if($opcion)
		{
		    my $pattern = '* te gusta *';
		    introducir_texto(@texto);
		    mostrar_mensaje_largo($pattern, $contador);
		}
		else
		{
		    my $pattern = 'te gusta *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gusta');
		}
		$output = 0;
	    }

	    if($texto[$contador-1] =~ /^me$/g)
	    {
		my $opcion = int(rand(2)); #Alterno entre la opcion _ me gusta * y me gusta *, ya que ambas tienen la misma estructura.
		if($opcion)
		{
		    my $pattern = '_ me gusta *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gusta');
		}
		else
		{
		    my $pattern = 'me gusta *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gusta');

		}
		$output = 0;
	    }
	}

	if($key =~ /^gustan$/g && $output == 1)
	{
	    if($texto[$contador-1] =~ /^te$/g)
	    {
		my $opcion = int(rand(2)); #Alterno entre la opcion _ te gustan * y te gustan *, ya que ambas tienen la misma estructura.
		if($opcion)
		{
		    my $pattern = '_ te gustan *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gustan');
		}
		else
		{
		    my $pattern = 'te gustan *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gustan');
		}

		$output = 0;
	    }

	    if($texto[$contador-1] =~ /^me$/g)
	    {
		my $opcion = int(rand(2)); #Alterno entre la opcion _ me gusta * y me gusta *, ya que ambas tienen la misma estructura.
		if($opcion)
		{
		    my $pattern = '_ me gustan *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gustan');
		}
		else
		{
		    my $pattern = 'me gustan *';
		    introducir_texto(@texto);
		    mostrar_mensaje($pattern, $contador,'gustan');

		}
		$output = 0;
	    }
	}

	
	if($key =~ /^a$/g && $output == 1)
	{
	    if($texto[$contador-1] =~ /^conoces$/g)
	    {
		my $opcion = int(rand(2)); #Alterno entre la opcion _ conoces a * y conoces a *, ya que ambas tienen la misma estructura.

		if($opcion)
		{
		    my $pattern = '_ conoces a *';
		    introducir_texto(@texto);
		    mostrar_mensaje_largo($pattern, $contador);
		}
		else
		{
		    my $pattern = 'conoces a *';
		    introducir_texto(@texto);
		    mostrar_mensaje_largo($pattern, $contador);
		}
		$output = 0;
	    }
	}

	if($key =~ /^eres$/g && $output == 1)
	{
	    my $opcion = int(rand(2)); #Alterno entre la opcion _ eres * y eres *, ya que ambas tienen la misma estructura.

	    if($opcion)
	    {
		my $pattern = '_ eres *';
		introducir_texto(@texto);
		mostrar_mensaje_largo($pattern, $contador);
	    }
	    else
	    {
		my $pattern = 'eres *';
		introducir_texto(@texto);
		mostrar_mensaje_largo($pattern, $contador);
	    }
	    $output = 0;
	}


	if($key =~ /^estoy$/g && $output == 1)
	{
	    my $opcion = int(rand(2)); #Alterno entre la opcion _ estoy * y estoy *, ya que ambas tienen la misma estructura.

	    if($opcion)
	    {
		my $pattern = '_ estoy *';
		introducir_texto(@texto);
		mostrar_mensaje_largo($pattern, $contador);
	    }
	    else
	    {
		my $pattern = 'estoy *';
		introducir_texto(@texto);
		mostrar_mensaje_largo($pattern, $contador);
	    }
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

    if($output == 1)
    {
	print "Sara > Interesante. Cuéntame más. \n";
	print "Yo > ";
    }
}

# Puedo intentar o un hash de arrays o dos hashes que cada uno estén en orden, es decir, para la clave 1 del primer hash este "SARA" y para la clave 1 del segundo hash este la respuesta asociada
