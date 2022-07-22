#include "gcd.h"

int gcde(int a, int b) {

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