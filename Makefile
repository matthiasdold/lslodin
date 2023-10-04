# CC = gcc
CC = x86_64-w64-mingw32-gcc-13.1.0.exe
AR = x86_64-w64-mingw32-gcc-ar.exe
CFLAGS = -Wall -O2
# LSLLIB = /opt/homebrew/lib/
# LSLLIB = C:\Users\matth\workspace\python\venvs\wvenv3.11\Lib\site-packages\pylsl\lib
LSLLIB = .
INCLUDES = ./include

.PHONY: run buildc buildc_standalone clean

run:
	odin run . --extra-linker-flags:"/LIBPATH ./lib/lsl.lib"
	# odin run . -extra-linker-flags:"-L$(LSLLIB) -llsl"

buildc:
	@echo "Building shared object from C code"
	$(CC) -c ./src/lslodin.c -I$(INCLUDES) -I./lib/
	$(AR) rcs lslodin.lib lslodin.o
	mv lslodin.lib ./lib/
	mv lslodin.o ./lib/

buildc_standalone:
	$(CC) $(CFLAGS) -o lslodin.exe ./src/lslodin.c -llsl -L$(LSLLIB) -I$(INCLUDES) -I./lib/

clean:
	rm -rf lslodin.o lslodin.obj lslodin.exe src/lslodin.o include/lslodin.o include/liblslodin.a
