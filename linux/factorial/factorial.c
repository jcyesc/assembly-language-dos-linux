#include <stdio.h>

int factorialIterativo(int number);
int factorialRecursivo(int number);
/*
The function repetirFactorial was programmed to be compared with the version
in assembly language.

We're trying to test if the version compile is faster than the was written by hand (factorialassembly.asm).

PROGRAM IN C

real	0m3.754s
user	0m0.092s
sys	0m0.112s

PROGRAN IN ASSEMBLY LANGUAGE

real	0m3.647s
user	0m0.084s
sys	0m0.108s

The program in ASSEMBLY LANGUAGE was a little faster.

*/
void repetirFactorial();

int main()
{
	printf("Iterative and Recursive Factorial Functions\n");

	int result = factorialIterativo(5);
	printf("\nFactorial(%d) = %d", 5, result);

	result = factorialRecursivo(6);
	printf("\nFactorial(%d) = %d\n", 6, result);

	repetirFactorial();
}

int factorialIterativo(int number)
{
	int tmp = number;
	if(number <= 1)
		return 1;

	while(number != 1)
		tmp *= --number;

	return tmp;
}

int factorialRecursivo(int number)
{
	if(number <= 1)
		return 1;
	else
		return number * factorialRecursivo(number - 1);
}

void repetirFactorial()
{
	int counter;
	for(counter = 0; counter < 100000; counter++) {
		printf("Counter = %d\n", counter);
		factorialRecursivo(10);
 	}
}
