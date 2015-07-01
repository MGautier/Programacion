#!/usr/bin/perl

use strict;

open my $file, '<', 'fichero.txt' or die "No se pudo abrir el fichero $!";

while(<$file>)
{
	my @uno = split($file);
	foreach my $key (@uno)
	{
		if($key !~ s|<(.*?)>||g)
			{
				print $key;
			}
	}
	#while ( s/<script.*(?)<\/script>//sg ) 
	#{
	#	my $array = $1;
	#	my $meow = $2;
	#	print "$array $meow\n";
	#}
}
#s/(<.+?>)//sg
close $file;
