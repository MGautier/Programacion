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
	Tarea 4-2 - Mi segundo script
	</title>
	<meta name="keywords" content="scripts,php">
  </head>
<body>
<?php
	echo "<p> Esta es mi segunda tarea del curso </p>";
	$contador = 0;
	for($contador; $contador < 10; ++$contador)
	{
		echo "<p>";

		if($contador < 5)
		{
			echo "<b> $contador </b>";
		}
		else
		{
			echo  "<i> $contador </i>";	
		}

		echo "</p>";
	}
?>
</body>
</html>
