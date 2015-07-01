CXX = g++
CXXFLAGS = -ansi -pedantic -Wall
OBJETOS = fecha.o pruebafecha.o
OBJETOS2 = fecha.o prueba-auto.o
CABECERA = fecha.h fct.h 
EXE = pruebafecha

all:$(EXE)

$(OBJETOS):$(CABECERA)
$(OBJETOS2): fecha.h

$(EXE):$(OBJETOS)
	$(CXX) $(LDFLAGS) -o $@ $^

test:	$(OBJETOS2)
	$(CXX) $(LDFLAGS) -o prueba-auto $^
	./prueba-auto

clean:
	$(RM) $(OBJETOS) $(OBJETOS2) $(EXE) prueba-auto core *~