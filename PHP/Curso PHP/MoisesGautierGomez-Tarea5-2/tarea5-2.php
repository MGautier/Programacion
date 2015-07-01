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
	Tarea 5-2 - BD con PHP
	</title>
	<meta name="keywords" content="scripts,php">
  </head>
<body>
<p> Esta es mi tarea de PHP + MySql </p>
<?php
$servidor = "localhost";
$usuario = "usuario";
$pass = "1234";
$BD = "curso_php";

$conexion = @mysql_connect($servidor,$usuario,$pass,$BD);
if(!$conexion){
	die('<strong>No pudo conectarse:</strong> ' . mysql_error());
}

mysql_select_db($BD,$conexion) or die (mysql_error($conexion));

$sql = 'SELECT * FROM datos_php';
$consulta = mysql_query($sql,$conexion);

if(!$consulta)
{
	echo "Error de BD, no se pudo consultar la base de datos\n";
	echo "Error MySQL: " . mysql_error();
	exit;
}

	echo "Nombre: {$_POST['nombre']} \n <br>";
	echo "Apellido1: {$_POST['apellidos1']} \t Apellido2: {$_POST['apellidos2']} \n <br>";
	echo "Teléfono: {$_POST['telefono']} \n <br>";
	echo "Dirección: {$_POST['direccion']} \t Número: {$_POST['numero']} \t Piso: {$_POST['piso']} \t CP: {$_POST['cp']} <br>";
	echo "Localidad: {$_POST['localidad']} \t Provincia: {$_POST['provincia']} <br>";


	echo "<br> Datos almacenados previamente en la base de datos \n";
while ($fila = mysql_fetch_assoc($consulta)) {
	echo "<br><br><br><hr>";
    echo "Nombre:" . $fila["Nombre"] . "\n" . "Apellidos: " . $fila["Apellidos1"] . "\n" . $fila["Apellidos2"] . "\n" . "<br><br> Telefono: " . $fila["Telefono"] . "\n" . "Direccion:" . $fila["Direccion"] . "\n" . "Numero:" . $fila["Numero"] . "\n" . "Piso:" . $fila["Piso"] . "\n" . "CP:" . $fila["CP"] . "\n" . "<br><br> Localidad: " . $fila["Localidad"] . "\n" . "Provincia: " . $fila["Provincia"] . "\n" ."<br><br>";
}

$sql_insert = "INSERT INTO datos_php (Nombre, Apellidos1, Apellidos2, Telefono, Direccion, Numero, Piso, CP, Localidad, Provincia) VALUES ('$_POST[nombre]','$_POST[apellidos1]','$_POST[apellidos2]','$_POST[telefono]','$_POST[direccion]',$_POST[numero],'$_POST[piso]','$_POST[cp]','$_POST[localidad]','$_POST[provincia]')";

if(!mysql_query(utf8_encode($sql_insert),$conexion))
{
	echo "Error MySQL: " . mysql_error();
}	

mysql_free_result($consulta);
mysql_close($conexion);
?>

<form action="formulario.html">
<br><input type="submit" value="Volver">
</form>
</body>
</hmtl>

