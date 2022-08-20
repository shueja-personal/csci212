#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_PILES 45
#define printarr(fmt, dat, len)	for (int i = 0; i < len; i++) if(dat[i] != 0) printf(fmt, dat[i])





int findLowestOpen(int* piles) {
    for (int i=0; i <= NUM_PILES-1; i++) {
        if(piles[i] == 0) {
            return i;
        }
    }
    return NUM_PILES-1;
}

void dealCards(int* piles) {
    int i = NUM_PILES;
    for (; i > 1;) {
        int amt = 1 + rand() % (i-1); // a random number of the remaining cards.
        i -= amt;
        piles[findLowestOpen(piles)] = amt;
    }
    piles[findLowestOpen(piles)] = i;
}

void solitaireStep(int* piles) {
    int newPile = 0;
    for (int i=0; i <= NUM_PILES-1; i++) {
        if(piles[i] != 0) {
            piles[i]--;
            newPile++;
        }
    }
    piles[findLowestOpen(piles)] = newPile;
}

int checkSuccess(int* piles) {
    int array[9] = {1, 1, 1, 1, 1, 1, 1, 1, 1};
    for (int i=0; i < NUM_PILES; i++) {
        if(piles[i] > 0 && piles[i] < 10) {
            if(array[piles[i]-1] == 1) {
                array[piles[i]-1] = 0;
            } else {
                return 0;
            }
        }
    }
    for (int i = 0; i < 9; i++) {
        if(array[i] == 1) {
            return 0;
        }
    }
    return 1;
}

int main() {
    srand(time(0));
    int piles[NUM_PILES] = {0};
    dealCards(piles);
    while(!checkSuccess(piles)){
        printarr("%d, ", piles, NUM_PILES);
        printf("\n");
        solitaireStep(piles);
        
    }
    printarr("%d, ", piles, NUM_PILES);
    int success = checkSuccess(piles);

}

