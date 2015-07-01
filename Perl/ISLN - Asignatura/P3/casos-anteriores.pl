for my $etiqueta ( $xml->findnodes('/aiml/category') ) {
    #print $etiqueta->nodeName(), "\n";
    foreach my $hijo ( $etiqueta->getChildnodes ) {
	my $valores = [];
        if ( $hijo->nodeType() == XML_ELEMENT_NODE ) {

	    if($hijo->nodeName() =~ 'pattern')
	    {
		$clave = $hijo->textContent();
	    }
	    if($hijo->nodeName() =~ 'template')
	    {
		push(@$valores, $hijo->textContent());
	    }
        }

	$hash{$clave} = $valores;
    }
}

foreach my $key (sort keys %hash)
{
    print "El valor primero de $key \n";
    foreach my $value (@{$hash{$key}})
    {
	print "\t $value \n";
    }
}

# Puedo intentar o un hash de arrays o dos hashes que cada uno estén en orden, es decir, para la clave 1 del primer hash este "SARA" y para la clave 1 del segundo hash este la respuesta asociada


		for my $aux ( $hijo->findnodes('/random') )
		{
		    print $aux->textContent(),"\n";
		    if($aux->nodeName() =~ 'li')
		    {
			print "Estoy por aquí";
			print $aux->textContent();
			push(@$valores, $aux->textContent());
		    }
		}
