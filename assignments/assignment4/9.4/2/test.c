/* test.c
 * A main function to print return values.
 * 2017-09-29: Bob Plantz
 */

#include <stdio.h>
#include "./test.h"
/* Prototype of the called function so the
 * compiler knows how to compile the call
 * to the function. Use your function's name.
 */

int main()
{
   int retvalue;
   
   retvalue = f();
   
   printf("return value = %i\n", retvalue);
   
   return 0;
}