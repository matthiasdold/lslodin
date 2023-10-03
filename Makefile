CC = gcc
CFLAGS = -Wall -g
LSLLIB = /opt/homebrew/lib/
INCLUDES = ./include


run:
	odin run . -extra-linker-flags:"-L/opt/homebrew/lib -llsl"

buildc:
	echo "Building shared object from C code"
	$(CC) -c ./src/lslodin.c
	ar rcs liblslodin.a lslodin.o
	mv liblslodin.a ./include/
	mv lslodin.o ./include/

buildc_standalone:
	$(CC) $(CFLAGS) -o lslodin.o ./src/lslodin.c -llsl -L$(LSLLIB) -I$(INCLUDES)

clean:
	rm -rf lslodin.o liblslodin.a testlsl src/lslodin.o include/lslodin.o include/liblslodin.a
