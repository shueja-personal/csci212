#include "gcd.h"

// This is not used directly to generate the assembly code, but rather to test and layout my algorithm before manual translation.
int gcdc(int a, int b) {

	while(a != 0) {
		if (a - b < 0) {
			// swap
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
		}
		//a = a % b; // a is now the remainder, less than b. They will swap on the next iter
		int c = a / b; // integer division
		c = c * b;
		a -= c;
		if (a != 0) {
			// go to top
		}
	}
	return b;
}