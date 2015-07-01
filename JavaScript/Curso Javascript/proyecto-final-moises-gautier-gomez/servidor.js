#!/usr/bin/nodejs

function Tareas(dia,contenido,realizada)
{
    this.dia = dia;
    this.contenido = contenido;
    this.realizada = realizada;
    this.toString = toString;
}

function contenido()
{
    return ""+this.contenido;
}

function dia()
{
    return ""+this.dia;
}

function realizada()
{
    return ""+this.realizada;
}

function toString() {
    return "{ \"dia\": \""+this.dia+"\",\"contenido\": \""+this.contenido+"\",\"realizada\": \""+this.realizada+"\"}";
}

var tareitas = new Array;

var express=require('express'); 
var app = express(); 


var puerto=process.argv[2]?process.argv[2]:8080; 
var index = -1;
var array_json = [];

// Con este metodo muestro la pagina principal desde el servidor

app.get('/', function (req, res) { 
	res.sendFile('./cliente.html', {root: __dirname }); 
});  

// Con este metodo realizo busquedas en la clase tareitas segun la cadena
// que se haya pasado desde el cliente. El valor de retorno es en JSON

app.get('/busqueda/:cadena', function( req, res ) {

    var busqueda_json = [];
    for(var it=0; it < tareitas.length; it++)
    {
	if(tareitas[it].contenido.indexOf(req.params.cadena) > -1)
	{
	    busqueda_json.push({ dia: tareitas[it].dia, contenido: tareitas[it].contenido, realizada: tareitas[it].realizada});
	}
    }

    res.send(JSON.stringify(busqueda_json));
    busqueda_json = [];
    
});

// Con este metodo realizo el listado de tareas almacenadas en el array_json

app.get('/listado', function (req, res) { 
    
    console.log(JSON.stringify(array_json));
    res.send(JSON.stringify(array_json));
   
});

// Con este metodo inserto una nueva tarea en el servidor

app.post('/nuevo/:dia/:contenido/:realizado', function (req, res) { 
    index++;
    tareitas[index] = new Tareas(""+req.params.dia+"",""+req.params.contenido+"",""+req.params.realizado+""); 
    array_json.push({ dia: tareitas[index].dia, contenido: tareitas[index].contenido, realizada: tareitas[index].realizada});
    console.log(JSON.stringify(array_json[index]));
    res.send(JSON.stringify(array_json[index]));
    
}); 

// Con este metodo, desde linea de comandos, inserto una nueva tarea en el servidor

app.put('/push/:dia/:contenido/:realizado', function (req, res) { 
    index++;
    tareitas[index] = new Tareas(""+req.params.dia+"",""+req.params.contenido+"",""+req.params.realizado+""); 
    array_json.push({ dia: tareitas[index].dia, contenido: tareitas[index].contenido, realizada: tareitas[index].realizada});
    res.send(JSON.stringify(tareitas[index].toString));
    
});

app.listen(puerto); 
console.log('Servidor funcionando en http://127.0.0.1:'+puerto+'/');
