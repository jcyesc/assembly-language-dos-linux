main: main.o library.o
	gcc main.o library.o -o main
library.o: library.asm
	nasm -f elf library.asm
main.o: main.asm
	nasm -f elf main.asm

