#!/usr/bin/perl
use CGI qw/:standard :netscape/;

$CGI::POST_MAX=1024 * 100;  # max 100K posts
$CGI::DISABLE_UPLOADS = 1;  # no uploads

#
# Fichero Tarea3-2.pl
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


# Alumno: Moisés Gautier Gómez
# Titulacion: Ingeniería en Informática
# Programación de servidores web HTML, Perl/CGI, PHP y My SQL, 5ª Edición

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
    -title=>'Tarea 3-2 - Quiero comprarme un buga',
    -author=>'Moises Gautier Gomez',
    -meta=>{'keywords'=>'coches,lamborghini,euros,comprar'},
    -encoding=>"utf-8",
    -lang=>"es-ES",
    -dtd=>[ '-//W3C//DTD HTML 4.01 Transitional//ES', 'http://www.w3.org/TR/html4/loose.dtd' ],
    -style=>{-code=>$estilos});

print center(h1('Mi web será las más molona'));
print center(h2('El objetivo de mi página web es enseñar como dejarnos la pasta de una manera elegante comprando un montón de coches caros.'));
print center(h4('Automobili Lamborghini Holding S.p.A., comúnmente conocido como Lamborghini (pronunciado [lamboɾˈɡiːni] en italiano y [lamboɾˈɡini] en castellano, usualmente [lamboɾˈʝini] en España), es un fabricante italiano de automóviles deportivos fundado en 1963 por el fabricante de tractores Ferruccio Lamborghini cuyos nombres de autos hacen referencia a nombres de toros de lidia famosos. (1997-actualidad). Ferruccio se instaló en Sant\'Agata Bolognese, en Bolonia, a pocos kilómetros de Maranello, para rivalizar con su vecino, Enzo Ferrari, a raíz de una pelea por la calidad de sus coches.[cita requerida] La empresa original se llamaba Automobili Ferruccio Lamborghini SpA, que derivaba a su vez de la Lamborghini Trattori S.A..
		Desde los primeros coupés deportivos hasta los actuales "Reventón", "Aventador" y "Gallardo", los Lamborghini siempre se han destacado por sus prestaciones y sus diseños exóticos.'));


#Con este mecanismo comprobamos si hay algún dato enviado por post en nuestro navegador en ese momento

if($ENV{'REQUEST_METHOD'} eq "POST")
{
    print center(h2('Dado que quieres comprar un puñao de coches aquí te dejo el carrito de la compra:'));
    
    print start_form(-method => "GET", -action => "./tarea3-2.cgi");
    
# Abrimos el fichero en donde haremos la escritura para el carrito
# de productos comprados

    my $fichero = "../htdocs/carrito.txt";
    
    open my $carrito, ">>", $fichero or die "No existe un fichero de salida $fichero porque $!\n";
    
    my $cgi = CGI->new;
    
    $cgi->save(\*$carrito);
    close($carrito);

    open my $mostrar_carrito, "<", $fichero or die "No existe un fichero de salida $fichero porque $!\n";

    while(!eof($mostrar_carrito))
    {
	my $compras = CGI->new(\*$mostrar_carrito);
	
	print "Fecha y hora del envío de la información \t \t", $compras->param('fecha-hora'), br, br;

	print "¿Cuántas unidades desea del vehículo? \t \t", $compras->param('unidades'), br,br,
	"\t Seleccione el modelo que desea comprar: \t", $compras->param('vehiculos'),
	br,br,
	" Elija el precio de su coche: \t", $compras->param('precio'),
	br,br,
	" Elija el color de su coche: \t", $compras->param('color'), $compras->param('otro_color'),
	br,br,
	" Introduce el número de cuenta del banco: \t", $compras->param('banco1'), "\t - \t", 
	$compras->param('banco2'), "\t - \t", 
	$compras->param('banco3'), "\t - \t", 
	$compras->param('banco4'),
	br,br,
	" Introduce la direccion dónde desea recibirlo: \t", $compras->param('tipo_via')," \t - \t", 
	$compras->param('nombre_direccion'), "\t , Número: \t", 
	$compras->param('numero_direccion'), "\t , Piso: \t", 
	$compras->param('piso_direccion'), "\t , \t CP: ", $compras->param('cp_direccion'),
	br,br,
	" ¿Deseas algún extras más? \t", $compras->param('extras'),
	br,br,hr,br,
	;

    }
    
    close $mostrar_carrito;

    print "\t", submit(-name=>'index',
		       -value=>'Regresar a index'),
    "\t",
    reset(-name=>'reiniciar',
	  -value=>'Borrar todo')
	;
    
    
}
else
{
    print br;

    print start_form(-method => "POST", -action => "./tarea3-2.cgi");
    print "¿Cuántas unidades desea del vehículo?\t \t", textfield(-name=>'unidades',
								  -default=>'',
								  -override=>1,
								  -size=>5,
								  -maxlength=>5),
    "\t Seleccione el modelo que desea comprar: \t",
    popup_menu(-name=>'vehiculos',
	       -values=>[qw/Gallardo Murcielago Reventor Veneno Aventador/],
	       -labels=>{'Gallardo'=>'Gallardo',
			 'Murcielago'=>'Murcielago',
			 'Reventor'=>'Reventor',
			 'Veneno'=>'Veneno',
			 'Aventador'=>'Aventador'},
	       -default=>'one'),
    br,br
	;
    print "Elija el precio de su coche: \t",
    radio_group(-name=>'precio',
		-values=>['6.000 €','12.000 €','18.000 €','¡Gratis!'],
		-default=>'',
		-linebreak=>'',
		-labels=>\%labels,
		-attributes=>\%attributes),
    br,br
	;
    print "Elija el color de su coche: \t",
    radio_group(-name=>'color',
		-values=>['Amarillo pollito','Dorado oro','Rojo pasión'],
		-default=>'',
		-linebreak=>'',
		-labels=>\%labels,
		-attributes=>\%attributes),
    "\t Otro color:",
    textfield(-name=>'otro_color',
	      -default=>'',
	      -override=>1,
	      -size=>20,
	      -maxlength=>20),
    br,br
	;
    print "Introduce el número de cuenta del banco \t",
    textfield(-name=>'banco1',
	      -default=>'',
	      -override=>1,
	      -size=>4,
	      -maxlength=>4),
    "\t",
    textfield(-name=>'banco2',
	      -default=>'',
	      -override=>1,
	      -size=>4,
	      -maxlength=>4),
    "\t",
    textfield(-name=>'banco3',
	      -default=>'',
	      -override=>1,
	      -size=>2,
	      -maxlength=>2),
    "\t",
    textfield(-name=>'banco4',
	      -default=>'',
	      -override=>1,
	      -size=>10,
	      -maxlength=>10),
    br,br
	;
    print "Introduce la direccion dónde desea recibirlo: \t",
    popup_menu(-name=>'tipo_via',
	       -values=>[qw/Calle Avenida Residencial Urbanización Camino/],
	       -labels=>{'Calle'=>'Calle',
			 'Avenida'=>'Avenida',
			 'Residencial'=>'Residencial',
			 'Urbanización'=>'Urbanizacion',
			 'Camino'=>'Camino'},
	       -default=>'Calle'),
    "\t ",
    textfield(-name=>'nombre_direccion',
	      -default=>'',
	      -override=>1,
	      -size=>50,
	      -maxlength=>50),
    "\t Número: \t",
    textfield(-name=>'numero_direccion',
	      -default=>'',
	      -override=>1,
	      -size=>5,
	      -maxlength=>5),
    "\t Piso: \t",
    textfield(-name=>'piso_direccion',
	      -default=>'',
	      -override=>1,
	      -size=>10,
	      -maxlength=>10),
    "\t Código postal: \t",
    textfield(-name=>'cp_direccion',
	      -default=>'',
	      -override=>1,
	      -size=>5,
	      -maxlength=>5),
    br,br
	;
    print "¿Deseas algún extras más? \t",
    textfield(-name=>'extras',
	      -default=>'',
	      -override=>1,
	      -size=>50,
	      -maxlength=>50),
    br,br
	;
    
    #También voy a almacenar el tiempo en el que se hace el envío.
    my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
    
    #La variable $mon se situa en el rango de 0 a 11, siendo 0 January (Enero) y 11 December (Diciembre),
    #por ello sumo 1 al valor para adaptarlo a nuestro sistema de fechas.
    $mes = $mon + 1;

    print hidden(-name=>'fecha-hora',-value=>[$mday."-".$mes."-".($year+1900)." ".$hour.":".$min.":".$sec, "\t"]);
    print "\t", submit(-name=>'enviar',
		       -value=>'Comprar',
		       -onClick=>"return confirm('¡Menuda pasta te has dejado!')"),
    "\t",
    reset(-name=>'reiniciar',
	  -value=>'Borrar todo')
	;

}
print end_html;
