/* stringDisplay
 *
 */
#include <stdio.h>

int main(void)
{
  char *stringPtr = "Dude, where's my car?aaa";
  while (*stringPtr != '\0') {
	printf("%p: 0x%02x\n", stringPtr, *stringPtr);
	stringPtr++;
  }
  return 0;
}