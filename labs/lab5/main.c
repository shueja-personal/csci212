#include <stdlib.h>
#include <time.h>
#include <stdio.h>

void print_array(int *arr, int size);
int checkEmpty(int*); 
int deal(int *deck, int *hand);
void print_prompt(int player);
int get_player_guess(void);
int give(int *giver, int *asker, int ask);
void print_hud(int* hand, int playerScore, int computerScore);
int draw(int* deck, int* hand);


/**int deal(int *deck, int *hand) {
    int cardsDealt = 0;
    
    while(1) {
        if (cardsDealt >= 7) {
            break;
        }
        if (checkEmpty(deck)) {
            break;
        }
        
        int idx = rand() % 13;
        if (0-deck[idx] >= 0) {
            continue;
        }
        deck[idx]--;
        hand[idx]++;
        cardsDealt++;

    }
    return 0;
}*/


// void print_prompt(int player) {
//     if (player == 0) {
//         printf("Computer: ");
//     }
//     else {
//         printf("Player: ");
//     }
// }

/**
    returns input 1-13
*/
/*int get_player_guess(void) {
    int n = 0;
    while (n > 13 || n < 1) {
        printf("Ask the computer for: ");
        scanf("%d", &n);
    }
    return n;
}*/

/*int give(int *giver, int *asker, int ask); /* {
    int errorCode=0;
    while(1) {
        int idx = ask-1;
        if (0-giver[idx] >= 0) {
            errorCode = 0;
            break;
        }
        giver[idx]--;
        asker[idx]++;
        errorCode = 1;
        break;
    }
    return errorCode;
}*/

void print_hand(int* hand) {
    int i = 0;
    while(1) {
        if (i >= 13) {
            break;
        }
        printf(" %d ", hand[i]);
        i++;
    }
    printf("\n");
}

/*void print_hud(int* hand, int playerScore, int computerScore); /* {
    int i = 0;
    while(1) {
        if (i >= 13) {
            break;
        }
        if(hand[i] !=0)
        printf("%d ", i+1);
        i++;
    }
    printf("Your Score: %d | Computer Score: %d", playerScore, computerScore);
    printf("\n");
}
 */
/*int draw(int* deck, int* hand) {
    int errorCode=0;
    if(checkEmpty(deck)){
        return errorCode;
    }
    int idx = 0;
    while(1) {
        idx = rand() % 13;
        if (deck[idx] <= 0) {
            continue;
        } else {
            break;
        }
    }
    deck[idx]--;
    hand[idx]++;
    errorCode = idx+1;
    return errorCode;
}*/

// int checkPair(int *hand, int ask) {
//     int errorCode = 0;
//     if (hand[ask] >=2) {
//         hand[ask] -= 2;
//         errorCode = 1;
//     }
//     return errorCode;
// }

int checkAllPairs (int *deck);/* {
    int errorCode = 0;
    int i = 0;
    while(1){
        if(i >= 13) {
            errorCode = 0;
            break;
        }
        if(checkPair(deck, i)) {
            errorCode = i+1;
            break;
        }
        i++;
    }

    return errorCode;
}*/

int getComputerGuess(int* computerHand) {
    return 1;
}

int processPairs(int* hand, int player, int* score);/* {
    while(1) {
        int pair = checkAllPairs(hand);
        if(pair == 0) {
            break;
        }
        else {
            print_prompt(player);
            printf("Lays down a pair of %ds.\n", pair);
            *score = *score+1;
        }
    }
}*/

/*int main(void) {
    srand(time(0));

    int deck[13] = {/*1, 1, 1, 1, 
    1, 1, 1, 1, 
    1, 1, 1, 1, 1* /
    4, 4, 4, 4,
     4, 4, 4, 4,
      4, 4, 4, 4, 4};
    int computer[13];
    int player[13];
    int computerScore = 0;
    int playerScore = 0;
    deal(deck, player);
    deal(deck, computer);
    print_hand(player);
    processPairs(player, 1, &playerScore);
    processPairs(computer, 0, &computerScore);
    print_hand(computer);
    print_hand(player);
    print_hud(player, playerScore, computerScore);
    
    while(1) {
        // player turn
        int ask = get_player_guess();
        if(give(computer, player, ask)) {
            print_prompt(0);
            printf("Gives you one %d\n", ask);
        } else {
            print_prompt(0);
            printf("Sorry, go fish. \n");
            int pickup = draw(deck, player);
            if(!pickup) {
                printf("Deck is empty!\n");
            }
            else {
                print_prompt(1);
                printf("Picked up a %d.\n", pickup);
            }
        }
        processPairs(player, 1, &playerScore);
        
        //print_hand(computer);
        print_hud(player, playerScore, computerScore);
        printf("\n");
        // refill(deck, computer);
        // refill(deck, player);
    
        // Computer turn
        ask = getComputerGuess(computer);
        print_prompt(0);
        printf("Do you have a %d.\n", ask);
        if(give(player, computer, ask)) {
            print_prompt(1);
            printf("*sigh* Here's one %d\n", ask);
        } else {
            print_prompt(1);
            printf("Computer, go fish. \n");
            int pickup = draw(deck, computer);
            if(!pickup) {
                printf("Deck is empty!\n");
            }
            else {
                printf("Computer picked up a card.\n");
            }
        }
        processPairs(computer, 0, &computerScore);
        //print_hand(computer);
        print_hud(player, playerScore, computerScore);
        printf("\n");
        // refill(deck, computer);
        // refill(deck, player);
        if (playerScore + computerScore == 26) {
            break;
        }

    }

    if(playerScore > computerScore) {
        printf("You Win!\n");
    } else if (playerScore == computerScore) {
        printf("Tied Game!\n");
    } else {
        printf("Computer Wins :(\n");
    }
}  */ 