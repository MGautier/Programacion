package parser;
use strict;
use XML::Simple;
use XML::LibXML;
use utf8;
use warnings;
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

binmode(STDOUT, ":utf8");
binmode(STDIN, ":encoding(utf8)");

#Autor: Moises Gautier Gomez
#5º Ingenieria en informatica
#Asignatura: Interfaces Software en Lenguaje Natural
#Practica 3 - Ejercicio 1 [modulo parser]



BEGIN
{
    require Exporter;
    
    our $VERSION = 1.00;
    
    our @ISA= qw( Exporter );
    
    our @EXPORT = qw( xml_cgi mostrar_mensaje mostrar_mensaje_largo introducir_texto leer_xml sara hash_return prompt ); #Funciones y variables que se exportaran por defecto
    
    our @EXPORT_OK = qw( mostrar_opciones cambiar_prompt ); #Funciones y vaiables que se exportaran opcionalmente
    
}

# Variables publicas

# Variables privadas

my $fuente;
my $xml;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

my %hash; #Hash interno del modulo para operar con el
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

my $clave; #Variable que hara de pattern a la hora de buscar en el hash

my $prompt = "Yo > ";

my @frase; #Array interno que nos servira para manipular la entrada estandar del usuario


# Procedimiento introducir_texto
# Precondicion: @frase, recibe como parametro un array que sera el texto que el usuario a introducido por entrada estandar
# Postcondcion: Devuelve dicho contenido como un array interno para su manipulacion

sub introducir_texto
{
    @frase = @_;
}

# Procedimiento cambiar_prompt
# Precondicion: $new_prompt, recibe como parametro una cadena que sera el nuevo mensaje del prompt del programa
# Postcondicion: Devuelve por salida estandar el mensaje prompt definido

sub cambiar_prompt
{
    my ($new_prompt) = @_;
    if(!$new_prompt)
    {
	print "Parametro de entrada incorrecto: vacío \n";
	$prompt = "Yo > ";
    }
    else
    {
	$prompt = $new_prompt;

    }
}

# Procedimiento prompt
# Precondicion: No recibe ningun parametro de entrada
# Postcondicion: Devuelve por salida estandar el mensaje prompt definido

sub prompt
{
    print $prompt;
}

# Procedimiento leer_xml
# Precondicion: $name, recibe como parametro el nombre del archivo .xml
# Postcondicion: Crea un hash de array con la estructura o jerarquia del .xml leido.

sub leer_xml
{
    my($name) = @_;

    $fuente = XML::LibXML->new(); #Creamos una instancia de la biblioteca LibXML
    $xml = $fuente->parse_file($name); #Parseamos el documento xml a un formato manejable en perl

    for my $etiqueta( $xml->findnodes('/aiml/category') )
    {
	my $valores = [];
	my ($pattern) = $etiqueta->findnodes('./pattern');
	
	$clave = $pattern->to_literal; #Aquí almaceno mi clave del hash que sera el pattern
	$clave =~ tr/[ÁÉÍÓÚÜÑÇ]/[áéíóúüñç]/;
	$clave =~ tr/A-Z/a-z/;
	$clave =~ s/\*/(.*)/sg;
	my ($template) = $etiqueta->findnodes('./template');
	
	my ($random) = $template->findnodes('./random');

	for my $answers ( $random->findnodes('./li') )
	{
	    $answers =~ s/<bot name="botmaster"\/>/$bot{'botmaster'}/;
	    $answers =~ s/<bot name="master"\/>/$bot{'master'}/;
	    $answers =~ s/<bot name="nombre_bot"\/>/$bot{'nombre_bot'}/;
	    $answers =~ s/<bot name="ciudad"\/>/$bot{'ciudad'}/;
	    $answers =~ s/<bot name="edad"\/>/$bot{'edad'}/;
	    $answers =~ s/<bot name="anyo_nacimiento"\/>/$bot{'anyo_nacimiento'}/;
	    $answers =~ s/<bot name="ciudadania"\/>/$bot{'ciudadania'}/;
	    $answers =~ s/<date.*?>/$bot{'hora'}/;
	    
	    #Lo que hago en vez de insertar en el array el $answers->to_literal
	    # es filtrar el contenido de esta variable para que sepa a la hora
	    # de que me llegue un pattern con *, saber que lado del texto se encuentra
	    # la expresion regular. A saber: RIGHT -> lado derecho, LEFT -> lado izquierdo
	    # así cuando me pasen el pattern por parametro de entrada y tenga *
	    # poder comprobar con una expresion regular si contiene o no lo anterior y
	    # manipular el texto de salida de acuerdo a dicha informacion.
	    
	    $answers =~ s/<star\/>/RIGHT /g;
	    $answers =~ s/<star index="1"\/>/LEFT /g;
	    $answers =~ s/<star index="2"\/>/RIGHT /g;
	    $answers =~ s/<li>/ /g;
	    $answers =~ s/<\/li>/ /g;
	    push(@$valores,$answers->to_literal);
	    
	}
	
	$hash{$clave} = $valores;
	
    }
}

# Funcion hash_return
# Precondicion: No recibe ningun parametro de entrada
# Postcondicion: Devuelve el hash creado en la lectura del archivo .xml

sub hash_return
{
    if(!%hash)
    {
	print "El hash está vacío\n";
	return 0;
    }
    else
    {
	return %hash;
    }
}

# Procedimiento sara
# Precondicion: No recibe ningun parametro de entrada
# Postcondicion: Devuelve por salida estandar un mensaje de inicio

sub sara
{
    print "Bienvenido, mi nombre es Sara. ¿De qué tema quiere hablar? \n";
    prompt();
}

# Procedimiento mostrar_opciones
# Precondicion: No recibe ningun parametro de entrada
# Postcondicion: Devuelve por salida estandar las finalidades de las funciones del paquete

sub mostrar_opciones
{
    print "Mostrar opciones:\n";
    print "mostrar_mensaje : Devuelve por salida estandar el mensaje de respuesta de Sara [Contiene patterns del estilo _ <palabra> *]\n";
    print "mostrar_mensaje_largo: Devuelve por salida estandar el mensaje de respuesta de Sara [Contiene patterns del estilo * <palabra> *] \n";
    print "hash_return : Devuelve el hash creado en la lectura del archivo .xml \n";
    print "sara : Devuelve por salida estandar un mensaje de inicio \n";
    print "leer_xml : Crea un hash de array con la estructura o jerarquia del .xml leido \n"; 
}

# Procedimiento mostrar_mensaje
# Precondicion: $pattern, recibe como parametro de entrada el pattern para buscar en el xml; $posicion, recibe como parametro de entrada la posicion en la que hay encontrado el pattern
# Postcondicion: Devuelve por salida estandar las respuestas de Sara segun los parametros de entrada

sub mostrar_mensaje_largo
{
    my ($pattern,$posicion) = @_;
    
    #pattern -> tendra la clave para buscar el array en el hash
    #posicion -> sera la posicion dentro de stdin que se ha encontrado el pattern
    
    my $size = @{$hash{$pattern}};
    my $elto = int(rand($size));

    my @subcadena = split(/\s+/,$hash{$pattern}[$elto]); #Convierto el string en un array en donde cada componente es una parte del string original

    # Prefiero hacerlo recorriendo las posiciones del array y no sirviendo la informacion yo manualmente en un print porque si cambia el contenido para dicho esquema xml
    # con cambiar los valores o las claves de los indices del array ya seria suficiente dado que el esquema vendria a ser igual para todos.
    
    my $contador; #Lo utilizo para recorrer desde la clave right hasta el final del array @frase
    $contador = $posicion;

    print "Sara >";
    foreach my $value (@subcadena)
    {
	if($value =~ /LEFT/ || $value =~ /RIGHT/)
	{
	    if($value =~ /LEFT/)
	    {
		print "$frase[$posicion-1] ";
		$value =~ s/^LEFT$//sg;
	    }

	    if($value =~ /RIGHT/)
	    {
		$value =~ s/^RIGHT$//sg;
		$contador++;
		while((scalar @frase) > $contador)
		{
		    print "$frase[$contador] ";
		    $contador++;
		}

	    }	    
	}
	else
	{
	    print "$value ";
	}

    }
    print "\nYo > ";
}

# Procedimiento mostrar_mensaje_largo
# Precondicion: $pattern, recibe como parametro de entrada el pattern para buscar en el xml; $posicion, recibe como parametro de entrada la posicion en la que hay encontrado el pattern
# Postcondicion: Devuelve por salida estandar las respuestas de Sara segun los parametros de entrada

sub mostrar_mensaje
{
    my ($pattern,$posicion,$sub_pattern) = @_;
    
    #pattern -> tendra la clave para buscar el array en el hash
    #posicion -> sera la posicion dentro de stdin que se ha encontrado el pattern
    
    my $size = @{$hash{$pattern}};
    my $elto = int(rand($size));

    my @subcadena = split(/\s+/,$hash{$pattern}[$elto]); #Convierto el string en un array en donde cada componente es una parte del string original

    # Prefiero hacerlo recorriendo las posiciones del array y no sirviendo la informacion yo manualmente en un print porque si cambia el contenido para dicho esquema xml
    # con cambiar los valores o las claves de los indices del array ya seria suficiente dado que el esquema vendria a ser igual para todos.

    print "Sara >";
    foreach my $value (@subcadena)
    {
	if($value =~ /^$sub_pattern$/)
	{
	    print "$value ";
	    $posicion++;
	    while((scalar @frase) > $posicion)
	    {
		print "$frase[$posicion] ";
		$posicion++;
	    }
	}
	else
	{
	    $value =~ s/^RIGHT$//sg;
	    print "$value ";
	}

    }
    print "\nYo > ";

}

sub xml_cgi
{
    my ($texto,$filename) = @_;

    my $fuente = XML::LibXML->new(); #Creamos una instancia de la biblioteca LibXML
    my $xml = $fuente->parse_file($filename); #Parseamos el documento xml a un formato manejable en perl

    for my $etiqueta( $xml->findnodes('/aiml/category') )
    {
	my $valores = [];
	my ($pattern) = $etiqueta->findnodes('./pattern');
	
	$clave = $pattern->to_literal; #Aquí almaceno mi clave del hash que sera el pattern
	$clave =~ tr/[ÁÉÍÓÚÜÑÇ]/[áéíóúüñç]/;
	$clave =~ tr/A-Z/a-z/;
	$clave =~ s/\*/(.*)/sg;
	my ($template) = $etiqueta->findnodes('./template');
	
	my ($random) = $template->findnodes('./random');

	my $aux;

	for my $aux ( $random->findnodes('./li') )
	{
	    my $answers = $aux->toString();
	    $answers =~ s/<bot name="botmaster"\/>/$bot{'botmaster'}/;
	    $answers =~ s/<bot name="master"\/>/$bot{'master'}/;
	    $answers =~ s/<bot name="nombre_bot"\/>/$bot{'nombre_bot'}/;
	    $answers =~ s/<bot name="ciudad"\/>/$bot{'ciudad'}/;
	    $answers =~ s/<bot name="edad"\/>/$bot{'edad'}/;
	    $answers =~ s/<bot name="anyo_nacimiento"\/>/$bot{'anyo_nacimiento'}/;
	    $answers =~ s/<bot name="ciudadania"\/>/$bot{'ciudadania'}/;
	    $answers =~ s/<date.*?>/$bot{'hora'}/;
	    
	    #Lo que hago en vez de insertar en el array el $answers->to_literal
	    # es filtrar el contenido de esta variable para que sepa a la hora
	    # de que me llegue un pattern con *, saber que lado del texto se encuentra
	    # la expresion regular. A saber: RIGHT -> lado derecho, LEFT -> lado izquierdo
	    # así cuando me pasen el pattern por parametro de entrada y tenga *
	    # poder comprobar con una expresion regular si contiene o no lo anterior y
	    # manipular el texto de salida de acuerdo a dicha informacion.
	    
	    $answers =~ s/<star\/>/RIGHT /g;
	    $answers =~ s/<star index="1"\/>/LEFT /g;
	    $answers =~ s/<star index="2"\/>/RIGHT /g;
	    $answers =~ s/<li>/ /g;
	    $answers =~ s/<\/li>/ /g;
	    push(@$valores,$answers);
	    
	}
	
	$hash{$clave} = $valores;
	
    }

    my $cadena;
    my $contador;
    my $left;
    my $right;
    
    while($texto)
    {
	chomp;
    
	$cadena = $texto;
	$cadena =~ s/[!?¿¡,;:\.]//sg;
	$cadena =~ tr/[A-Z]/[a-z]/;
	$cadena =~ tr/\Á/á/;
	$cadena =~ tr/\É/é/;
	$cadena =~ tr/\Í/í/;
	$cadena =~ tr/\Ó/ó/;
	$cadena =~ tr/\Ú/ú/;
	
	my $output; # Uso esta variable para almacenar si hay devuelve un resultado o no por salida estandar
	$output = 1;
	
	if($cadena =~ s/adios//)
	{
	    return "$hash{'adios'}[rand(3)]";
	}

	foreach my $claves (keys %hash)
	{
	    #print "Mi key es: $cadena y mi claves es: $claves \n";
	    if($cadena =~ m/$claves/ && $output == 1)
	    {
		$left = $1;
		$right = $2;
		if($hash{$claves})
		{
		    my $size = @{$hash{$claves}};
		    my $elto = rand($size);

		    $hash{$claves}[$elto] =~ s/LEFT/$left/sg;
		    
		    if($right)
		    {
			$hash{$claves}[$elto] =~ s/RIGHT/$right/sg;
		    }
		    else
		    {
			$hash{$claves}[$elto] =~ s/RIGHT/$left/sg;
		    }
		    
		    return "$hash{$claves}[$elto]";
		    
		    $output = 0;
		}
	    }
	    
	}
    
	if($output == 1)
	{
	    return "Interesante. Cuéntame más";
	}
	
    }

}
END
{ }

1;


