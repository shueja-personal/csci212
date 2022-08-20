
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified


.text
.align 2
.global give
.type give, %function

@ int deal(int *deck, int *hand) {
@     int cardsDealt = 0;
    
@     while(1) {
@         if (cardsDealt >= 7) {
@             break;
@         }
@         if (checkEmpty(deck)) {
@             break;
@         }
        
@         int idx = rand() % 13;
@         if (0-deck[idx] >= 0) {
@             continue;
@         }
@         deck[idx]--;
@         hand[idx]++;
@         cardsDealt++;

@     }
@     return 0;
@ }

give:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of giver
    @ r1 = address of hand
    @ r2 = ask
    push {r0}
    push {r1}
    push {r2}
    
        // r0 has idx
        sub r2, r2, 1
        mov r3, r2, LSL #2
        @ if (0-deck[idx] >= 0) {
        @    continue;
        @}
        ldr r1, [fp, -8] // load the deck array pointer
        ldr r0, [r1, r3] // load the element from that
        cmp r0, 0 // if it's 0
        moveq r0, 0 // failed to give
        beq end // pick a different card


        sub r0, r0, 1 // decrement from the giver
        str r0, [r1, r3]

        ldr r1, [fp, -12] // increment the player's hand
        ldr r0, [r1, r3]
        add r0, r0, 1
        str r0, [r1, r3]

        mov r0, 1

        b end

    end:
    sub sp, fp, #4
    pop {fp, pc}
