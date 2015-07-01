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
	Tarea 4-4 - Mi cuarto script
	</title>
	<meta name="keywords" content="scripts,php">
  </head>
<body>
<p> Esta es mi cuarta tarea del curso de PHP </p>
<?php

class Carrito {
	var $items; 

	function agregar_item($tipo, $num) {
	
		if(isset($this->items[$tipo])) {
			$this->items[$tipo] += $num; 
		}else{
			$this->items[$tipo] = $num; 
		}
	}

	function retirar_item($tipo, $num) {
		if ($this->items[$tipo] > $num) {
			$this->items[$tipo] -= $num;
			return true;
		} elseif ($this->items[$tipo] == $num) {
			unset($this->items[$tipo]);
			return true;
		} else {
			return false;
		}
	}

	function items_carrito_tipo($tipo)
	{
		/*
			La función isset determina si una variable esta definida y no es NULL
			por lo tanto no nos da la excepción que lanza y podemos capturarla
			con nuestra nueva clase Exception y así mostrar un mensaje adecuado al usuario.
		*/
		try{
			if(isset($this->items[$tipo]))
			{
				return $this->items[$tipo];
			}
			else
			{
				throw new Exception("No se encuentra el tipo {$tipo} de producto dentro del carrito \n ->");				
			}
		}catch(Exception $ex){
			echo $ex->getMessage();
			return " --- \n";
		}		
			
	}

	function items_total()
	{
		$sum = 0;

		foreach($this->items as $key => $value)
		{
			$sum += $value;
		}
	
		return $sum;
	}

	function mostrar_carrito()
	{	
		echo "Contenido del carrito: \n <br>";

		foreach($this->items as $key => $value)
		{
			echo "Tipo: $key Cantidad: $value \n <br>";
		}

	}
}

	$carrito = new Carrito;
	$carrito->agregar_item("Ordenador", 1);
	$carrito->agregar_item("Mouse",2);
	$carrito->agregar_item("Monitor",3);
	$carrito->agregar_item("Teclado",4);
	$carrito->agregar_item("Usb",5);
	$carrito->agregar_item("Altavoces",6);
	$carrito->agregar_item("Lector",8);
	$carrito->agregar_item("Impresora",9);
	$carrito->agregar_item("Escaner",10);


	echo "Del item Ordenador hay {$carrito->items_carrito_tipo("Ordenador")} unidad/es \n <br> <br>";
	echo "Del item Lector hay {$carrito->items_carrito_tipo("Lector")} unidad/es \n <br> <br>";
	echo "Del item Mesa hay {$carrito->items_carrito_tipo("Mesa")} unidad/es \n <br> <br>";
	echo "Items totales: {$carrito->items_total()} unidades \n <br> <br>";
	echo "{$carrito->mostrar_carrito()} \n <br>";


?> 
</body>
</html>
