@ int main(void) {
@     srand(time(0));

@     int deck[13] = {/*1, 1, 1, 1, 
@     1, 1, 1, 1, 
@     1, 1, 1, 1, 1*/
@     4, 4, 4, 4,
@      4, 4, 4, 4,
@       4, 4, 4, 4, 4};
@     int computer[13];
@     int player[13];
@     int computerScore = 0;
@     int playerScore = 0;
@     deal(deck, player);
@     deal(deck, computer);
@     print_hand(player);
@     processPairs(player, 1, &playerScore);
@     processPairs(computer, 0, &computerScore);
@     print_hand(computer);
@     print_hand(player);
@     print_hud(player, playerScore, computerScore);
    
@     while(1) {
@         // player turn
@         int ask = get_player_guess();
@         if(give(computer, player, ask)) {
@             print_prompt(0);
@             printf("Gives you one %d\n", ask);
@         } else {
@             print_prompt(0);
@             printf("Sorry, go fish. \n");
@             int pickup = draw(deck, player);
@             if(!pickup) {
@                 printf("Deck is empty!\n");
@             }
@             else {
@                 printf("You picked up a %d.\n", pickup);
@             }
@         }
@         processPairs(player, 1, &playerScore);
        
@         //print_hand(computer);
@         print_hud(player, playerScore, computerScore);
@         printf("\n");
@         // refill(deck, computer);
@         // refill(deck, player);
    
@         // Computer turn
@         ask = getComputerGuess(computer);
@         print_prompt(0);
@         printf("Do you have a %d.\n", ask);
@         if(give(player, computer, ask)) {
@             print_prompt(1);
@             printf("*sigh* Here's one %d\n", ask);
@         } else {
@             print_prompt(1);
@             printf("Computer, go fish. \n");
@             int pickup = draw(deck, computer);
@             if(!pickup) {
@                 printf("Deck is empty!\n");
@             }
@             else {
@                 printf("Computer picked up a card.\n");
@             }
@         }
@         processPairs(computer, 0, &computerScore);
@         //print_hand(computer);
@         print_hud(player, playerScore, computerScore);
@         printf("\n");
@         // refill(deck, computer);
@         // refill(deck, player);
@         if (playerScore + computerScore == 26) {
@             break;
@         }

@     }

@     if(playerScore > computerScore) {
@         printf("You Win!\n");
@     } else if (playerScore == computerScore) {
@         printf("Tied Game!\n");
@     } else {
@         printf("Computer Wins :(\n");
@     }
@ }   

.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
    computerGivesYouStr: .asciz "Gives you one %d\n"
    goFishStr: .asciz "Sorry, go fish.\n"
    emptyDeckStr: .asciz "Deck is empty!\n"
    youPickedUpStr: .asciz "Picked up a %d. \n"
    computerAsksYouStr: .asciz "Do you have a %d?\n"
    youGiveComputer: .asciz "Gives the computer one %d\n"
    computerPickedUpStr: .asciz "Picked up a card.\n"
    youWinStr: .asciz "You Win!\n"
    tieGameStr: .asciz "Tied Game!\n"
    computerWinsStr: .asciz "Computer Wins :(\n"
    out: .asciz "arr: %p fp: %p sp:%p \n"
.text
.equ COMP_SCORE_PTR, -8
.equ PLAYER_SCORE_PTR, -12
.equ DECK, PLAYER_SCORE_PTR - (4*13) // 8 (fp, lr) + 8 (scores) + 13*4
.equ COMPUTER_HAND, DECK - (4*13) // 68+52
.equ PLAYER_HAND, COMPUTER_HAND - (4*13)
.align 2
.global main
.type main, %function

main:
    push {fp, lr}
    add fp, sp, 4 //sp = fp-4

    mov r0, 0
    bl time
    bl srand

    mov r0, 0
    push {r0}
    push {r0} //sp=fp-12

    sub sp, sp, 52*3 //156, sp = fp-168

    // init deck
    add r0, fp, DECK
    mov r1, 13
    mov r2, 4
    bl fillArray

    mov r3, sp
    mov r2, fp
    add r1, fp, DECK
    ldr r0, =out
    bl printf

    add r0, fp, COMPUTER_HAND
    mov r1, 13
    mov r2, 0
    bl fillArray

    add r0, fp, PLAYER_HAND
    mov r1, 13
    mov r2, 0
    bl fillArray


    add r0, fp, DECK
    add r1, fp, PLAYER_HAND
    bl deal

    add r0, fp, DECK
    add r1, fp, COMPUTER_HAND
    bl deal

    add r0, fp, PLAYER_HAND
    mov r1, 13
    add r2, fp, PLAYER_SCORE_PTR
    bl print_array

    

    sub sp, fp, 4
    pop {fp, pc}

    
    