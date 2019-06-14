#include <stdio.h>


int main()
{
	float sum = 0.0f, z = 0.001f;
	int i = 1;
	for(; i <= 1000; i++)
		sum = sum + z;
        printf("%f", sum);
	return 1;
}
