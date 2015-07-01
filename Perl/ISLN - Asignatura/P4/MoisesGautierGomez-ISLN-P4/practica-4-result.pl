#!C:\Perl64\bin\perl
use CGI qw( :standard -utf8 :netscape );
use LWP::Simple qw/get/;
use strict;
use utf8;
use bd;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";
use CGI::Carp 'fatalsToBrowser'; #Esto permite introducir resultados de debug en el navegador a la hora de ejecutar

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");



#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Práctica 4

my $idf = 0;
my %tf;
my $nPags = 4;
my %tfidf;
my $indice = 1;

my @secciones = ("http://motor.as.com/motor/","http://motor.as.com/motor/formula_1.html","http://motor.as.com/motor/motociclismo.html","http://motor.as.com/motor/mas_motor.html");

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
    -title=>'ISLN - Práctica 4',
    -meta=>{'charset'=>'utf-8','keywords'=>'nubre,etiquetas,web'},
    -encoding=>"utf-8",
    -lang=>"es-ES",
    -dtd=>[ '-//W3C//DTD HTML 4.01 Transitional//ES', 'http://www.w3.org/TR/html4/loose.dtd' ],
    -style=>{-code=>$estilos});


print center(h1('ISLN - Práctica 4: Buscadores'));

print start_form(-method => "POST", -action => "./practica-4.cgi");

print "\t", submit(-name=>'index',
		   -value=>'Volver al cgi');


if($ENV{'REQUEST_METHOD'} eq "POST")
{
    my $cgi = CGI->new;
    $cgi->charset('UTF-8');
    my $pregunta = $cgi->param('escribe');
    utf8::decode($pregunta); #Uso esta funcion para pasar el string a la forma interna de perl
    
    print p('Aquí se presenta la nube de etiquetas');

	foreach my $key (@secciones){
		my %hash;
		dbmopen(%hash,$indice,0666);
		if($hash{$pregunta}){
			$idf++; #Contamos las páginas donde aparece la palabra
			$tf{$key} = $hash{$pregunta}; #Almacenamos el número de ocurrencias en la página
		}
		dbmclose(%hash);
		$indice++;
	}
	
	if($idf > 0){
	
		$idf = log($nPags/$idf); #peso idf
		foreach my $key (keys %tf){
			$tfidf{$key} = $tf{$key}*$idf;
		}

		print p("Palabra $pregunta encontrada en las siguientes páginas, ordenadas por peso:");
		foreach my $key (sort {$tfidf{$b} <=> $tfidf{$a}} keys %tfidf){
			print "-> Web: $key => Valor tf-idf: $tfidf{$key} y su peso es $tf{$key}",p;
		}
	} 
	else{
		print p("No se ha podido encontrar la palabra $pregunta en ninguna de las secciones");
	}	
	

}

print end_form;
print end_html;
#Parser Practica 4 - Fin