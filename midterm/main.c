#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int generate_random_number(void);
// int generate_number() {
//     int r0 = rand();
//     int r1 = r0 / 30; // int division
//     r1 = r1 * 30;
//     r0 = r0 - r1;
//     return r0;
// }

int get_user_guess(void);
// int get_user_guess() {
//     int n = 0;
//     printf("Enter a number: ");
//     scanf("%d", &n);
//     return n;
// }

int main() 
{ 
    srand(time(0));
    int n = generate_random_number();
    int i = 0;
    for (; i < 5; i++) {
        int r0 = get_user_guess();
        int cmp = n - r0;
        if(cmp == 0) {
            printf("You got it! The number was %d\n", n);
            break;
        }
        else if (cmp >=0) {
            printf("Too low\n");
        }
        else if (cmp < 0) {
            printf("Too high\n");
        }
    }
    if (i == 5) {
        printf("Sorry! The number was %d\n", n);
    }
    return 0; 
} 

