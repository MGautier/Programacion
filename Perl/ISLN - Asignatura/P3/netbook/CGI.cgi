#!/usr/bin/perl
use CGI qw/:standard -utf8 :netscape/;
use Encode;
use parser;
use XML::Simple;
use XML::LibXML;
use utf8;
use warnings;
use Locale::Util;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");

$CGI::POST_MAX=1024 * 100;  # max 100K posts
$CGI::DISABLE_UPLOADS = 1;  # no uploads

#
# Fichero CGI.pl
# @author Moisés Gautier Gómez
# @version 1.0 5/5/14
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


#Introduzco directamente los estilos css en el html desde el cgi

my $estilos=<<END;
h1,h2,h3,h4,h5,h6,p,body{
  color:white;
    font-family:georgia;
}
body{
  background:#77787B;
}
END

    print header(-type => 'text/html', 'charset'=>'utf-8');
print start_html(
    -title=>'ISLN - Práctica 3',
    -author=>'Moises Gautier Gomez',
    -meta=>{'charset'=>'utf-8','keywords'=>'sara,isln,conversación'},
    -encoding=>"utf-8",
    -lang=>"es-ES",
    -dtd=>[ '-//W3C//DTD HTML 4.01 Transitional//ES', 'http://www.w3.org/TR/html4/loose.dtd' ],
    -style=>{-code=>$estilos});

print center(h1('Chat con Sara'));
#Con este mecanismo comprobamos si hay algún dato enviado por post en nuestro navegador en ese momento

print start_form(-method => "POST", -action => "./CGI.cgi");

# Abrimos el fichero en donde haremos la escritura para el carrito
# de productos comprados

my $fichero = "../htdocs/chat.txt";
my $sara;
my @answ;
my $pregunta;
my $res;
my $cadena;
my $filename;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
my %bot; #Hash interno del modulo para introducir informacion del bot del xml
%bot = (	nombre_bot => 'Sara',
		botmaster => 'Moisés',
		master => 'Moisés',
		ciudad => 'Cádiz',
		edad => '25',
		anyo_nacimiento => '1988',
		ciudadania => 'Francesa',
		hora => "$hour:$min:$sec"
    );								 

#my $accept = $ENV{'HTTP_ACCEPT'};
#my $user_agent = $ENV{'HTTP_USER_AGENT'};
#my $accept_charset = $ENV{'HTTP_ACCEPT_CHARSET'};
my $accept_language = $ENV{'HTTP_ACCEPT_LANGUAGE'};
#my $x_wap_profile = $ENV{'HTTP_X_WAP_PROFILE'};
#my $profile = $ENV{'HTTP_PROFILE'};

if($accept_language eq "en")
{
    $filename = "Philosophy.xml";
}
else
{
    $filename = "sara.xml";
}

if($ENV{'REQUEST_METHOD'} eq "POST")
{

open my $chat, ">>", $fichero or die "No existe un fichero de salida $fichero porque $!\n";
my $cgi = CGI->new;
$cgi->charset('UTF-8');
$pregunta = $cgi->param('escribe');
utf8::decode($pregunta); #Uso esta funcion para pasar el string a la forma interna de perl
#$pregunta = decode("UTF-8",$pregunta); #Uso ahora esta función para pasar del formato interno al formato utf-8
$res = &xml_cgi($pregunta,$filename);
$cadena .= "Yo > $pregunta\n";
$cadena .= "Sara > $res\n";
print $chat $cadena;
close($chat);


open my $mostrar_chat, "<", $fichero or die "No existe un fichero de salida $fichero porque $!\n";

while(<$mostrar_chat>)
{	
    shift;
    push(@answ,$_);
}

close $mostrar_chat;

}

print textarea(-name=>'respuesta',-id=>'respuesta',
	       -default=>"@answ",-readonly=>'readonly',
	       -override=>1,
	       -rows=>10,
	       -cols=>60);

print br;


print textfield(-name=>'escribe',
		-default=>'',
		-override=>1,
		-size=>50,
		-maxlength=>100);


print "\t", submit(-name=>'index',
		   -value=>'Regresar a index'),
    "\t",
    reset(-name=>'reiniciar',
	  -value=>'Borrar todo'    )
    ;



print end_html;

