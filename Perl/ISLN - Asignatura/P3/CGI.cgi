#!/usr/bin/perl
use CGI qw/:standard :netscape/;

$CGI::POST_MAX=1024 * 100;  # max 100K posts
$CGI::DISABLE_UPLOADS = 1;  # no uploads

#
# Fichero CGI.pl
# @author Moisés Gautier Gómez
# @version 1.0 3/12/13
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
    -meta=>{'keywords'=>'sara,isln,conversación'},
    -encoding=>"utf-8",
    -lang=>"es-ES",
    -dtd=>[ '-//W3C//DTD HTML 4.01 Transitional//ES', 'http://www.w3.org/TR/html4/loose.dtd' ],
    -style=>{-code=>$estilos});

print center(h1('Chat con Sara'));
#Con este mecanismo comprobamos si hay algún dato enviado por post en nuestro navegador en ese momento

    my $cgi = CGI->new;

    print start_form(-method => "POST", -action => "./tarea3-2.cgi");
    
# Abrimos el fichero en donde haremos la escritura para el carrito
# de productos comprados

    my $fichero = "../htdocs/chat.txt";
    
    open my $chat, ">>", $fichero or die "No existe un fichero de salida $fichero porque $!\n";
        
    $cgi->save(\*$chat);
    close($chat);

    open my $mostrar_chat, "<", $fichero or die "No existe un fichero de salida $fichero porque $!\n";

    my $sara;
    my @answ;


    while(!eof($mostrar_chat))
    {	
	my $cadena;	
    $sara = CGI->new(\*$mostrar_chat);
        $cadena .= "Yo > ".$sara->param('escribe');
        $cadena .= "\nSara > FUNCIONA\n";
	push(@answ,$cadena);

    }

    close $mostrar_chat;
	
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
	  -value=>'Borrar todo')
	;
    
    

print end_html;
