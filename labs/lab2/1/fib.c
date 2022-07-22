#include "fib.h"

int fib(int r0) {
	int n = r0;
	int r1 = 0;
	int r2 = 1;
	while(n > 1) {
		r1 = r2+r1;
		r2 = r1+r2;
		n--;
		n--;
	}
	if(n == 0) {
		r0 = r1;
	}
	if(n == 1) {
		r0 = r2;
	}
	return r0;
}