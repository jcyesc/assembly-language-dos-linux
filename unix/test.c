#include <stdio.h>

int sumar(int a, int b);
int mivariable = 23;

int main() {
  printf("\nHola a todos");

  printf("\nEste programa va a ser debugeado");

  int i;
  for(i = 0; i < 10; i++)
    printf("\n i = %d", i);

  int var1 = 34;
  int var2 = 5;
 
  printf("\nMi variable %d", mivariable);
  printf("\nSuma %d", sumar(var1, var2));
  printf("\n");
}

int sumar(int a, int b) {
  return a + b;
}


