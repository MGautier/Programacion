#!/usr/bin/perl

#
# Fichero Tarea3-1.perl
# @author Moisés Gautier Gómez
# @version 1.0 28/11/13
#

#
# ******************************************************************************
#                   (c) Copyright 2013 Moisés Gautier Gómez
# 
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ******************************************************************************
#


# Alumno: Moisés Gautier Gómez
# Titulacion: Ingeniería en Informática
# Programación de servidores web HTML, Perl/CGI, PHP y My SQL, 5ª Edición

my $salida = "parrafos.html";
my @texto;
my $fh;


if($ARGV[0] eq "")
{
	while(<>){
		chomp;
		push(@texto,"<p>",$_,"</p>\n");
	}

}
else
{
	my $fichero = $ARGV[0];
	open $fh,"<", $fichero or  die "No puedo abrir el fichero $fichero porque $!\n";
}

open my $sh, ">", $salida or die "No existe un fichero de salida $salida porque $!\n";

print $sh "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//ES\"
   \"http://www.w3.org/TR/html4/loose.dtd\">
<html lang=\"es\">
  <meta charset=\"utf-8\">
  <head>
	<title>Tarea 3 - Abrir ficheros con perl</title>
  </head>
<body>
<p>Aquí se presentan las lineas del fichero/entrada estándar leido del sistema </p>
";
if($ARGV[0] eq "")
{
	print $sh @texto;
}
else
{
	while(<$fh>)
	{
		chop;
		print $sh "<p> $_ </p> \n";
		print $sh "<br> \n";
	}
}
print $sh "</body>
</html>";

close($fh);
close($sh);


