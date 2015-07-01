CXX=g++
CXXFLAGS=-ansi -pedantic -Wall
OBJETOS= cadena.o pruebacadena.o
OBJETOS2= cadena.o prueba-auto.o
CABECERA= cadena.h fct.h
EXE= pruebacadena

all:$(EXE)

$(OBJETOS): $(CABECERA)
$(OBJETOS2): cadena.h

$(EXE):$(OBJETOS)
	$(CXX) $(LDFLAGS) -o $@ $^

test:$(OBJETOS2)
	$(CXX) $(LDFLAGS) -o prueba-auto $^
	./prueba-auto

clean:
	$(RM) $(OBJETOS) $(OBJETOS2) prueba-auto core *~