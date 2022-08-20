#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int pick_random_word(char*);
int fillByteArray(char*, int, char);
void print_status(char* guess, char* hangman, char* missed);
int advance_hangman(char* hangman);
int add_missed_letter(char* missed, char missedLetter);

int main(void) {
    srand(time(0));

    char word[15];
    fillByteArray(word, 15, '\0');
    int wordLength = pick_random_word(word);

    char guessedWord[15];
    fillByteArray(guessedWord, 15, '\0');
    fillByteArray(guessedWord, wordLength, '-');
    guessedWord[wordLength] = '\0';


    char missed[8];
    fillByteArray(missed, 7, '-');
    missed[7] = '\0';

    char hangman[8];
    fillByteArray(hangman, 7, '-');
    hangman[7] = '\0';
    
    printf("%s\n", word);
    print_status(guessedWord, hangman, missed);

    while (1) {
        int character = '\0';
        //get_player_guess
        while (1) {
            printf("Enter a character: ");

            scanf("%c", &character);
            if(character == '\n') {scanf("%c", &character);}
            if (!islower(character)) {continue;}
            
            else {break;}
            //  return character;
        }
        //

        // findReplace(word, character)
        // 0 if found, 1 if not found
        int scan_idx = 0;
        int flag = 1;
        while(1) {
            if (word[scan_idx] == '\0') {
                break;
            }
            if(word[scan_idx] == character) {
                guessedWord[scan_idx] = character;
                flag = 0;

            }
            scan_idx++;
        }
        // end search
        if(flag) {
            printf(">>>BZZ! Wrong<<<\n");
            if(advance_hangman(hangman) == 0) {
                printf("You Lose! it was %s", word);
            break;}
            add_missed_letter(missed, character);
        }
        else {
           
        }
        // checkSuccess
        int check_idx = 0;
        int check_flag = 1;
        while(1) {
            if(word[check_idx] == '\0') { break;}
            if (word[check_idx] != guessedWord[check_idx] ) {
                check_flag = 0;
                break;
            }
            check_idx++;
            //return check_flag
        }

        print_status(guessedWord, hangman, missed);
        if(check_flag) {
            printf("You Win!\n");
            break;
        }
    }

    return 0;

}