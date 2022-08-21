#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int pick_random_word(char*);
int fillByteArray(char*, int, char);
void print_status(char* guess, char* hangman, char* missed);
int advance_hangman(char* hangman);
int add_missed_letter(char* missed, char missedLetter);
void get_player_guess(int* character);
int find_replace(char* word, char* guessedWord, char search);
int check_success(char* word, char* guessedWord);

int main_c(void) {
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
    
    printf("\n", word);
    print_status(guessedWord, hangman, missed);

    while (1) {
        int character = '\0';
        //get_player_guess
        get_player_guess(&character);
        if(find_replace(word, guessedWord, character)) {
            printf(">>>BZZ! Wrong<<<\n");
            if(advance_hangman(hangman) == 0) {
                printf("You Lose! it was %s", word);
                break;
            }
            add_missed_letter(missed, character);
        }
        print_status(guessedWord, hangman, missed);
        if(check_success(word, guessedWord)) {
            printf("You Win!\n");
            break;
        }
    }

    return 0;

}