#include <stdio.h>

/* This program call a function developed in assembly language.
   The way to compile this functions is the following:
   
   nasm -f elf library.asm
   gcc -c linkedtest.c
   gcc linkedtest.o lbrary.o -o linkedtest

	The functions myfunction(), myfunctionparameters() and printtable() are
	defined in the library.asm.

*/
int main()
{
	printf("Calling functions made in assembly language");
 	printtable();
	myfunction();
	myfunctionparameters(2,3);
	myfunction();	
	printtable();	
	return 0;
}

