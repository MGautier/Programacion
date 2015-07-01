<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//ES"
   "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
  <meta charset="utf-8">
	<head>
	<style type="text/css">
		h1,h2,h3,h4,h5,h6,p,body{color:white;
			font-family:georgia;}

		body{background:#77787B;}
	</style>
	<title>
	Tarea 4-3 - Mi tercer script
	</title>
	<meta name="keywords" content="scripts,php">
  </head>
<body>
<?php
	
	// Tomamos la hora del sistema
	$hora_fecha = getdate();

	/*
		 Creo estos dos arrays para pasar a español la fecha que nos devuelve
		 el sistema que lo hace en el idioma por defecto que es el inglés.
	*/

	$dias = array("Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo");
	$meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");

	/*
		Restamos un día al valor que nos da el sistema dado que mi array
		empieza su índice para el valor 0 y el sistema empieza su cuenta
		tanto de meses como de días en 1.
	*/

	$dia_semana = $dias[$hora_fecha["wday"] - 1];
	$mes_anyo = $meses[$hora_fecha["mon"] - 1];
	$hora = "Hora: {$hora_fecha["hours"]} : {$hora_fecha["minutes"]} : {$hora_fecha["seconds"]} ";
	$fecha = "Fecha: $dia_semana {$hora_fecha["mday"]} de $mes_anyo del año {$hora_fecha["year"]} ";

	// Abro el fichero para lectura y escritura

	$fichero = fopen("log.txt","a+");

	if($fichero)
	{
		echo "<p> Esta es mi tercera tarea del curso de PHP</p>";
		echo "$hora <br> $fecha";

		fwrite($fichero,"$hora"."\t"."$fecha \n",strlen("$hora"."\t"."$fecha \n"));
	}

	fclose($fichero);
?>
</body>
</html>
