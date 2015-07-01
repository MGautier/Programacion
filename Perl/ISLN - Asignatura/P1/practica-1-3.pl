#!/usr/bin/perl

use strict;

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 1 - Ejercicio 3


open my $file, '<', 'quijote.txt' or die "No se pudo abrir el fichero $!";
my (%texto); #Hash con el contenido del archivo quijote.txt
my (%reves); #Hash con el contenido ordenado y del reves

my $totalpalabras = 0; #Variable que empleo para contar el numero de palabras
my $palabras_sin_repetir = 0; #Variable que empleo para contar el numero de palabras sin repetir
my (%bigrama); #Hash con el contenido de cada bigrama
my $bigram1; #Variable con el contenido de la posicion segunda del bigrama
my $bigram2=""; #Variable con el contenido de la posiciones primera del bigrama
my $may_min; #Variable donde almaceno el paso de mayusculas a minusculas de las palabras

    while (<$file>) 
	{
	#Aquí filtramos los elementos del texto que no sean relevantes, como
	# los signos de exclamación e interrogación, las comas, los puntos, etc.

	    while ( /(\b[^\W_\d][\w'-]+\b)/g ) 
		{ 
		    #Una vez hemos filtrado con la expresión regular almacenamos
		    # el contenido de la entrada estandar de la variable interna $1 en
		    # may_min para luego aplicar la expersion regular en la que transformamos
		    # las mayusculas a minusculas.

		    $may_min = $1;	    
		    $may_min =~ tr/\A-Z/a-z/;
		    $texto{$may_min}++; #Aquí vamos insertando en el hash las palabras encontradas

			foreach $bigram1 ($may_min)
			{
			   #Como tenemos en la variable may_min el contenido del archivo filtrado
			   # se lo pasamos como parametro al foreach para operar con cada elemento
			   # mediante nuestras operaciones de bigrama.
			   my $cadena = "$bigram2 $bigram1";
			   $bigram2 = $bigram1;
			   $bigrama{$cadena}++; #Aquí vamos insertando en el hash los bigramas construidos
			}
		}

		
    	}


	#Aqui simplemente vamos mostrando todas las palabras del texto y ordenadas
	# segun la frecuencia de su uso.

	print "\n El texto según FRECUENCIA es el siguiente : \n";
	
    foreach my $frecuencia (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		print "$frecuencia : $texto{$frecuencia}\n";
		$totalpalabras = $totalpalabras + $texto{$frecuencia};
	}

	print "\n El numero total de palabras es : $totalpalabras \n";
	$totalpalabras = 0; #Inicializo el contador a 0

	#Cambio el sentido de las palabras (al reves) del texto original extraido para
	# la realizacion de las rimas. Para ello ordeno el texto original y luego lo voy
	# rotando.

    foreach my $keys (sort keys %texto)
	{	
		my $value = reverse $keys;
		$reves{$value}++;
	}
    
	print "El texto según su RIMA es el siguiente : \n";

	#Ahora simplemente ordeno el contenido del reves que anteriormente utilice para
	# obtener asi la rima ordenada de las palabras del texto.

    foreach my $orden (sort keys %reves)
	{
		print "$orden \n";
		$palabras_sin_repetir = $palabras_sin_repetir + $reves{$orden};
	}
	print "\n El numero total de palabras sin repetir es :".$palabras_sin_repetir."\n";

	#Ordeno de mayor a menor frecuencia los bigramas generados anteriormente

	print "El texto según sus BIGRAMAS es el siguiente : \n";

    foreach my $keys (sort {$bigrama{$b}<=>$bigrama{$a}} keys %bigrama)
	{	
		print "$keys : $bigrama{$keys} \n";
	}
	
	#Aqui simplemente vamos mostrando todas las palabras del texto y ordenadas
	# segun la frecuencia de su uso y aquellas que contengan 4 letras al menos.

	print "\n El texto según el numero de letras (4) es el siguiente : \n";
	
    foreach my $frecuencia (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		if(length($frecuencia) == 4)
		{
			print "$frecuencia : $texto{$frecuencia}\n";
			$totalpalabras = $totalpalabras + $texto{$frecuencia};
		}
		
	}

	print "\n El numero total de palabras de 4 letras es : $totalpalabras \n";
	$totalpalabras = 0; #Inicializo el contador a 0

	#Aqui vamos mostrando todas las palabras del texto y ordenadas
	# segun la frecuencia de su uso y aquellas que no contengan vocales.

	print "\n El texto según el numero de letras (sin vocales) es el siguiente : \n";

    foreach my $frecuencia (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		#^[^aeiou]+$
		if($frecuencia !~ /[aeiou]/)
		{
			print "$frecuencia : $texto{$frecuencia}\n";
			$totalpalabras = $totalpalabras + $texto{$frecuencia};
		}
		
	}

	print "\n El numero total de palabras sin vocales es : $totalpalabras \n";
	$totalpalabras = 0; #Inicializo el contador a 0

	#Aqui vamos mostrando todas las palabras del texto y ordenadas
	# segun la frecuencia de su uso y aquellas que solo contengan una vocal.

	print "\n El texto según el numero de letras (una vocal) es el siguiente : \n";

    foreach my $frecuencia (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		
		if($frecuencia =~ /^[^aeiou]*[aeiou][^aeiou]*$/)
		{
			print "$frecuencia : $texto{$frecuencia}\n";
			$totalpalabras = $totalpalabras + $texto{$frecuencia};
		}
		
	}

	print "\n El numero total de palabras de una vocal es : $totalpalabras \n";
	$totalpalabras = 0; #Inicializo el contador a 0

	#Aqui vamos mostrando todas las palabras del texto y ordenadas
	# segun la frecuencia de su uso y aquellas que solo contengan dos vocales.

	print "\n El texto según el numero de letras (dos vocales) es el siguiente : \n";

    foreach my $frecuencia (sort{$texto{$b}<=>$texto{$a}} keys %texto)
	{
		
		if($frecuencia =~ /^[^aeiou]*[aeiou]{2}[^aeiou]*$/)
		{
			print "$frecuencia : $texto{$frecuencia}\n";
			$totalpalabras = $totalpalabras + $texto{$frecuencia};
		}
		
	}

	print "\n El numero total de palabras de dos vocales es : $totalpalabras \n";


	#Comento esta linea para tener apuntado como se hacen expresiones regulares
	# en perl mediante comandos unix.

        #system("echo hello world | rev");

close $file;
