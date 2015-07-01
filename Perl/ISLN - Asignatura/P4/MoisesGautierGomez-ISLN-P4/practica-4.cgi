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

$CGI::POST_MAX=1024 * 100;  # max 100K posts
$CGI::DISABLE_UPLOADS = 1;  # no uploads



#Practica 4 - Inicio


my $url = "http://motor.as.com/motor/";

my $body = get("http://motor.as.com/motor/"); #Está en utf-8
my (%stopw); #Hash con el contenido de las stopwords en español
open my $output, '>', 'output.txt' or die "No se pudo abrir el archivo $!";
open my $input, '<', 'stopwords.txt' or die "No se pudo abrir el archivo $!";

#Almaceno las stopwords en un hash para poder hacer comprobaciones con ellas
# más fácilmente.
while(<$input>)
{
    while ( /([^\W_\d]*[áéíóúüñç]*[^\W_\d]*)/g ) 
    { 
	$stopw{$1}++;
	my $may = ucfirst($1);
	$stopw{$may}++;
    }
}	

close $input;


my (%hash); #Aquí voy almacenando las ocurrencias de cada palabra encontrada.
my (%texto); #Hash con el contenido del archivo output.txt
my $num_bd = 1; #Me servirá para numerar las bases de datos.
my $tipo_parrafo = 0;

my @parrafos;
my @nom_propios;
my @secciones = $body =~ /<a href="(http:\/\/motor.as.com\/motor\/[^\W_\d].+?)">/sg;
my $new_seccion;

my $May = '[A-ZÁÉÍÓÚÑ]';
my $Min = '[a-záéíóúñ]';
my $empieza_may = "(?:$May$Min+)";
my $NP = "(?:$empieza_may(?: $empieza_may)*)";

my @parrafos_secciones; #Seran los nombre propios que encuentre para la primera web

$body =~ s/\.\s*([A-ZÑÁÉÍÓÚ])/. \l$1/sg;
#$body =~ tr/A-Z/a-z/; #Paso de mayusculas a minusculas.

if($tipo_parrafo)
{
    @parrafos = $body =~ /<p>(.+?)<\/p>/sg; #Filtra las etiquetas <p> y extrae su contenido y lo metemos en una lista.
}
else
{
    @parrafos = $body =~ /<p.*?>(.+?)<\/p>/sg; #Filtra las etiquetas <p class=....> y extrae su contenido y lo metemos en una lista.
}
my %hashweb;

dbmopen(%hashweb,$num_bd,0666);
foreach my $key (@parrafos)
{
    $key =~ s/<.+?>//sg; #Sustituye la etiqueta que encuentra por un espacio en blanco    
    $key =~ s/\&aacute;/á/g;
    $key =~ s/\&iacute;/í/g;
    $key =~ s/\&eacute;/é/g;
    $key =~ s/\&oacute;/ó/g;
    $key =~ s/\&uacute;/ú/g;
    $key =~ s/\&ntilde;/ñ/g;
    $key =~ s/\&Aacute;/Á/g;
    $key =~ s/\&Iacute;/Í/g;
    $key =~ s/\&Eacute;/É/g;
    $key =~ s/\&Oacute;/Ó/g;
    $key =~ s/\&Uacute;/Ú/g;
    $key =~ s/\&Ntilde;/Ñ/g;

    $key =~ s/[""“”‘’.,;:!¡¿?\(\)]//g;
    
    my @aux = $key =~ /($NP)/g; #De esta forma saco los nombres propios de la web

    foreach my $nombre (@aux)
    {
	$key =~ s/$nombre/ /sg;
	#Vamos almacenando los nombres propios de la web directamente en el hash y los voy borrando
	# del resto del texto anteriormente tratado.
	$texto{$nombre}++;
	$hashweb{$nombre}++;
    }

    my @words = split /\s+/, $key;
    foreach my $aux (@words)
    {
	if(!$stopw{$aux})
	{
		$hashweb{$aux}++;
        }
    }

    

    push(@nom_propios, @aux); 

    print $output lcfirst($key); #Imprimo el contenido de la web en un fichero y ejecuto lo que sería el código de la practica 1 para las frecuencias de palabras.
}
dbmclose(%hashweb);


foreach my $key (@secciones)
{
    print "Mis secciones son: $key \n";
    my %hashseccion;
    $num_bd++;
    dbmopen(%hashseccion,$num_bd,0666);
    $new_seccion = get("$key");
    $new_seccion =~ s/\.\s*([A-ZÑÁÉÍÓÚ])/. \l$1/sg;
    my @cadena; # Array auxiliar para almacenar los nombres propios de las diferentes secciones

    if($tipo_parrafo)
    {
	@parrafos_secciones = $new_seccion =~ /<p>(.+?)<\/p>/sg; #Filtra las etiquetas <p> y extrae su contenido y lo metemos en una lista.
    }
    else
    {
	@parrafos_secciones = $new_seccion =~ /<p.*?>(.+?)<\/p>/sg; #Filtra las etiquetas <p class=....> y extrae su contenido y lo metemos en una lista.
    }

    foreach my $key (@parrafos_secciones)
    {
	$key =~ s/<.+?>//sg; #Sustituye la etiqueta que encuentra por un espacio en blanco    
	$key =~ s/\&aacute;/á/g;
	$key =~ s/\&iacute;/í/g;
	$key =~ s/\&eacute;/é/g;
	$key =~ s/\&oacute;/ó/g;
	$key =~ s/\&uacute;/ú/g;
	$key =~ s/\&ntilde;/ñ/g;
	$key =~ s/\&Aacute;/Á/g;
	$key =~ s/\&Iacute;/Í/g;
	$key =~ s/\&Eacute;/É/g;
	$key =~ s/\&Oacute;/Ó/g;
	$key =~ s/\&Uacute;/Ú/g;
	$key =~ s/\&Ntilde;/Ñ/g;
    $key =~ s/[""“”‘’.,;:!¡¿?\(\)]//g;
	
	my @aux = $key =~ /($NP)/g; #De esta forma saco los nombres propios de la web

	foreach my $nombre (@aux)
	{
	    $key =~ s/$nombre/ /sg;
	    #Vamos almacenando los nombres propios de la web directamente en el hash y los voy borrando
	    # del resto del texto anteriormente tratado.

	    $texto{$nombre}++;
	    $hashseccion{$nombre}++;
	}

    	my @words = split /\s+/, $key;
    	foreach my $aux (@words)
    	{
			if(!$stopw{$aux})
			{
			$hashseccion{$aux}++;
        	}
    	}


	push(@nom_propios,@aux);
	
	print $output lcfirst($key); #Imprimo el contenido de la web en un fichero y ejecuto lo que sería el código de la practica 1 para las frecuencias de palabras.
    }    

    dbmclose(%hashseccion);
    #bd_crear($num_bd,%hashseccion);
}

close $output;


#Practica 4 - Fin
#
#
#
#Parser Practica 4 - Inicio


open my $file, '<', 'output.txt' or die "No se pudo abrir el fichero $!";


my @lista; #Aquí almaceno las palabras de la web sin stopwords, filtradas y dispuestas para la nube de etiquetas
my $totalpalabras = 0; #Variable que empleo para contar el numero de palabras
my $palabras_sin_repetir = 0; #Variable que empleo para contar el numero de palabras sin repetir
my $section;
my @cadena;


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


close $file;

foreach my $web (sort{$texto{$b}<=>$texto{$a}} keys %texto)
{
    #Compruebo si la palabras entrante esta en la lista de stopwords o no, si lo esta
    # no la almaceno en la lista final, si no esta sí.
    #$web =~ tr/A-Z/a-z/; #Paso de mayusculas a minusculas.
    if(!$stopw{$web})
    {
	push(@lista,$web);
    }

}


#Voy a definir el cuerpo del CGI

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
    -meta=>{'charset'=>'utf-8','keywords'=>'nubre,etiquetasrw-r--r-,web'},
    -encoding=>"utf-8",
    -lang=>"es-ES",
    -dtd=>[ '-//W3C//DTD HTML 4.01 Transitional//ES', 'http://www.w3.org/TR/html4/loose.dtd' ],
    -style=>{-code=>$estilos});


print center(h1('ISLN - Práctica 4: Buscadores'));

print start_form(-method => "POST", -action => 'http://localhost/cgi-bin/practica-4-result.pl');

print textfield(-name=>'escribe',
		-default=>'',
		-override=>1,
		-size=>50,
		-maxlength=>100);


print "\t", submit(-name=>'index',
		   -value=>'Buscar');


print end_html;
#Parser Practica 4 - Fin
