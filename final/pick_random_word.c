#include <stdio.h>
#include <stdlib.h>

int pick_random_word(char *buffer) {
    FILE *ptr;
    ptr = fopen("dictionary.txt", "r");
    int numWords = 0;
    fscanf (ptr, "%d", &numWords);
    int idx = rand() % numWords;
    idx++;
    int i = 0;
    while(1) {
        if(i >= idx) {
            break;
        }
        fscanf(ptr, "%s", buffer);
        i++;
    }
    int j = 0;
    while(1) {
        if (j == 15) break;
        if (buffer[j] == '\0') break;
        j++;
    }
    
    fclose(ptr);
    return j;

}