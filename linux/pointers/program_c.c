#include <stdio.h>

int x = 1;
int y = 1;
void f(int *p)
{
    *p++;           // The p address is incresea and then is deferenced, so it does not 
                    // affect x.
    printf("%d ", x);
    *(p++);
    printf("%d ", x);
    (*p)++;             // As the ++ and * have the same precedence, first the address is increased.

}
int main()
{
    f(&x);
    printf("%d ", x);
    printf("%d ", y);
}

