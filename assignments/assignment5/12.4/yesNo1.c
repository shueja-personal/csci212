/* yesNo1.c
 * Prompts user to enter a y/n response.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>

int main(void)
{
  char *prompt = "Save changes? ";
  char *yes = "Changes saved.\n";
  char *no = "Changes discarded.\n";
  char *response; // change this to a string

  while (*prompt != '\0') {
    write(STDOUT_FILENO, prompt, 1);
      prompt++;
  }

  read (STDIN_FILENO, &response, 2); // change this to 2 chars

  if (response[0] == 'y') { //check the first read-in char
    while (*yes != '\0') {
      write(STDOUT_FILENO, yes, 1);
      yes++;
    }
  } 
  else {
    while (*no != '\0') {
      write(STDOUT_FILENO, no, 1);
      no++;
    }
  }
  return 0;
}