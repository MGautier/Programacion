#!/usr/bin/perl

use strict;
use utf8;
use LWP::Simple;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

binmode(STDOUT, ":utf8");

#my $body = get("http://nnjt.wordpress.com/2011/11/22/capitulo-3-parte-1-fase-de-prueba-experimento-lr-100/"); #Está en utf-8
my $body = get("http://motor.as.com/motor/2014/03/29/formula_1/1396089160_669659.html"); #Está en utf-8
#my $body = get("http://www.ideal.es/granada/rc/20140328/deportes/mas-deporte/nadal-logra-sufrida-victoria-201403280322.html");

open my $output, '>', 'out.txt' or die "No se pudo abrir el archivo $!";

my (%hash); #Aquí voy almacenando las ocurrencias de cada palabra encontrada.
my $tipo_parrafo = 0;

my @parrafos;
my @lista_seccion;
my @secciones = $body =~ /<a href="(http:\/\/motor.as.com\/motor\/[^\W_\d].+?)">/sg;
my $new_seccion;

#$body =~ s/&.+?;//sg; #Elimino los caracteres especials &#xxxx.
#$body =~ tr/áéíóúüñçÁÉÍÓÚÜÑÇ/aeiouuncAEIOUUNC/; #Transformo las tildes y los signos de acentuación en otros que no lo sean



$body =~ tr/\A-Z/a-z/; #Paso de mayusculas a minusculas.

if($tipo_parrafo)
{
	@parrafos = $body =~ /<p>(.+?)<\/p>/sg; #Filtra las etiquetas <p> y extrae su contenido y lo metemos en una lista.
}
else
{
	@parrafos = $body =~ /<p.*?>(.+?)<\/p>/sg; #Filtra las etiquetas <p class=....> y extrae su contenido y lo metemos en una lista.
}

foreach my $key (@secciones)
{
	if($key =~ "formula_1")
	{
		print "Mis secciones $key\n";
		$new_seccion = get("$key");
	}
	
}

foreach my $key (@parrafos)
{
	$key =~ s/<.+?>//sg; #Sustituye la etiqueta que encuentra por un espacio en blanco
	print $output $key; #Imprimo el contenido de la web en un fichero y ejecuto lo que sería el código de la practica 1 para las frecuencias de palabras.
}

$new_seccion =~ tr/\A-Z/a-z/;

if($tipo_parrafo)
{
	@lista_seccion = $new_seccion =~ /<p>(.+?)<\/p>/sg; #Filtra las etiquetas <p> y extrae su contenido y lo metemos en una lista.
}
else
{	
	@lista_seccion = $new_seccion =~ /<p.*?>(.+?)<\/p>/sg; #Filtra las etiquetas <p class=....> y extrae su contenido y lo metemos en una lista.
}
my $aux=0;
foreach my $key (@lista_seccion)
{
	$key =~ s/<.+?>/ /sg; #Sustituye la etiqueta que encuentra por un espacio en blanco
	if(!$aux)
	{
		print $output $key; #Imprimo el contenido de la web en un fichero y ejecuto lo que sería el código de la practica 1 para las frecuencias de palabras.
		$aux = 1;
	}
	else
	{
		$aux = 0;
	}
}


close $output;
system("cat out.txt | sed 's/\&euro;/€/g' | sed 's/\&aacute;/á/g' | sed 's/\&eacute;/é/g' | sed 's/\&iacute;/í/g' | sed 's/\&oacute;/ó/g' | sed 's/\&uacute;/ú/g' | sed 's/\&ntilde;/ñ/g' > output.txt");
system("perl parser.pl > salida.txt");

