
CC = gcc
CFLAGS = -Wall -g
LSLLIB = /opt/homebrew/lib/
INCLUDES = ./include

run:
	odin run .

buildc:
	echo "Building shared object from C code"
	$(CC) $(CFLAGS) -o lslodin.o ./src/lslodin.c -llsl -L$(LSLLIB) -I$(INCLUDES)


buildc_test:
	$(CC) $(CFLAGS) -o testlsl ./src/lslodin.c -llsl -L/opt/homebrew/lib/ -I./include

# run:
# 	./testlsl

clean:
	rm -rf testlsl testlsl.o *.dSYM
