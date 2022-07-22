/* echoChar1.c
 * Echoes a character entered by the user.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>
#include <stdio.h>
#include <string.h>


int writeStr(char* ptr) {
  return write(STDOUT_FILENO, ptr, strlen(ptr));
}

int readLn(char* buf, int maxLen) {
    char aLetter;
    int len = 0;
    do {
	read(STDIN_FILENO, &aLetter, 1);
	if(aLetter != '\n' && len < maxLen) {
	    buf[len] = aLetter;
	    len++;
    	}
	else if (aLetter == '\n' || len == maxLen) {
	   buf[len] = '\0';
	   len++;
	}
    }
    while(aLetter != '\n' );
    return len;
}

int main(void)
{
  char aString[11];
  char *stringPtr = aString;
  do {
	readLn(stringPtr, 10);
  	writeStr(stringPtr);
	writeStr("\n");
  } while (aString[0] != '\0');
  return 0;
}
