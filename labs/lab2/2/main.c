#include <stdio.h>
#include "gcd.h"


int main() {
	int a = 0;
	int b = 0;
	printf("Enter first positive integer:\n");
	scanf("%d", &a);
	printf("Enter second positive integer:\n");
	scanf("%d", &b);
	printf("the gcd is %d\n", gcd(a, b));
	// int n=4;
	// int m=3;
	// int l=1;
	// printf("%d gcd %d = %d, expected %d, equal: %i\n", n, m, gcd(n, m), l, gcd(n,m)==l);
	// n=60;
	// m=44;
	// l=4;
	// printf("%d gcd %d = %d, expected %d, equal: %i\n", n, m, gcd(n, m), l, gcd(n,m)==l);
	// n=25;
	// m=5;
	// l=5;
	// printf("%d gcd %d = %d, expected %d, equal: %i\n", n, m, gcd(n, m), l, gcd(n,m)==l);
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