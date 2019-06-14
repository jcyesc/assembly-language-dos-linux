main: main.o libraryfile.o
	gcc main.o libraryfile.o -o main
main.o: main.asm
	nasm -f elf main.asm
libraryfile.o: libraryfile.asm
	nasm -f elf libraryfile.asm
