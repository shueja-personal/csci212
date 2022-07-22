/* echoChar1.c
 * Echoes a character entered by the user.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>

int main(void)
{
  char aLetter;
  char aString[200];
  char *stringPtr = aString;
  int len = 0;

  write(STDOUT_FILENO, "Enter one line: ", 16); // prompt user
  for (; len < 200 && aLetter != '\n'; len++) {
  	read(STDIN_FILENO, &aLetter, 1);                   // one character
	aString[len] = aLetter;
  }
  write(STDOUT_FILENO, "You entered: ", 13);         // message
  write(STDOUT_FILENO, stringPtr, len);                 // echo character
      
  return 0;
}