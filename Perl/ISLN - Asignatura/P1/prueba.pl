#!/usr/bin/perl

use strict;

open my $file, '<', 'quijote.txt' or die "No se pudo abrir el fichero $!";
my (%texto);
my $totalpalabras = 0;
	
    while (<$file>) 
	{
	    while ( /(\b[^\W_\d][\w'-]+\b)/g ) 
		{ 
		    my $may_min = $1;	    
		    $may_min =~ tr/\A-Z/a-z/;
		    $texto{$may_min}++;
		}
    	}
    while ( my ($palabra, $contador) = each %texto ) 
	{
	    print "$palabra $contador\n";
	    $totalpalabras = $totalpalabras + $contador;
	}

	print "El número total de palabras es: $totalpalabras \n";

close $file;
