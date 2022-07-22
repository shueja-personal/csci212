#include <stdio.h>
#include "fib.h"

//gcc -I. main.c fib.c Fibonacci.s; ./a.out

int main() {
	int n = 0;
	printf("Enter Fibonacci Term:\n");
	scanf("%d", &n);
	// printf("%d\n", fibonacci(26));
	// printf("%d\n", fibonacci(0));
	// int n=-5;
	// int m=-1;
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=0;
	// m=0;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=1;
	// m=1;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=2;
	// m=1;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=3;
	// m=2;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=4;
	// m=3;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=5;
	// m=5;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
	// n=6;
	// m=8;	
	// printf("the %dth Fibonacci number is %d, expected %d, equal: %i\n", n, fibonacci(n), m, fibonacci(n)==m);
}