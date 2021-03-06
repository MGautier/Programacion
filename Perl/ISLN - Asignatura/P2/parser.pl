#!/usr/bin/perl

use strict;
use utf8;
use Encode;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 2 - Ejercicio 1


open my $file, '<', 'output.txt' or die "No se pudo abrir el fichero $!";
open my $input, '<', 'stopwords.txt' or die "No se pudo abrir el archivo $!";
open my $html, '>', 'index.html' or die "No se pudo abrir el archivo $!";

my (%texto); #Hash con el contenido del archivo quijote.txt
my (%stopw); #Hash con el contenido de las stopwords en español
my @lista; #Aquí almaceno las palabras de la web sin stopwords, filtradas y dispuestas para la nube de etiquetas
my $totalpalabras = 0; #Variable que empleo para contar el numero de palabras
my $palabras_sin_repetir = 0; #Variable que empleo para contar el numero de palabras sin repetir

    while (<$file>) 
	{
	#Aquí filtramos los elementos del texto que no sean relevantes, como
	# los signos de exclamación e interrogación, las comas, los puntos, etc.

	    while ( /([^\W_\d]*[áéíóúüñç]*[^\W_\d]*)/g ) 
		{ 
		    #Una vez hemos filtrado con la expresión regular almacenamos
		    # el contenido de la entrada estandar de la variable interna $1
		    
		    $texto{$1}++; #Aquí vamos insertando en el hash las palabras encontradas

		}

		
    	}

	#Almaceno las stopwords en un hash para poder hacer comprobaciones con ellas
	# más fácilmente.
    while(<$input>)
	{
		while ( /([^\W_\d]*[áéíóúüñç]*[^\W_\d]*)/g ) 
		{ 
			$stopw{$1}++;
		}
	}	


    foreach my $web (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		#Compruebo si la palabras entrante esta en la lista de stopwords o no, si lo esta
		# no la almaceno en la lista final, si no esta sí.

		if(!$stopw{$web})
		{	
		 	push(@lista,$web);
		}

	}

	print "La web filtrada y sin stopwords es la siguiente\n";
	my $num_palabras = 20;
	print $html "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//ES\"
   \"http://www.w3.org/TR/html4/loose.dtd\">
<html lang=\"es\">
  <meta charset=\"utf-8\">
  <head>
	<title>Práctica 2 ISLN: Nube de etiquetas </title>
  </head>
<body>
<p>Aquí se presenta la nube de etiquetas </p>";
    foreach my $resultado (@lista)
	{
		$resultado =~ s/^f$/f\-1/sg;
		$resultado =~ s/^fórmula$/fórmula 1/sg;
		print "$resultado : $texto{$resultado}\n";
		if($num_palabras > 0)
		{
			print $html "<span style=\"font-size:$texto{$resultado}pt\"> $resultado </span> \n";
			$num_palabras--;
		}
	}

print $html "</body>
</html>";

close $input;
close $file;
close $html;
