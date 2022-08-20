.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data

.text
.align 2
.global init_decks
.type init_decks, %function


init_decks:
    @ save the containing method's fp and lr on the stack
    push {fp, lr}
    @ sp+0 now contains lr, and sp+4 now contains the value of fp (in the containing function)
    @ set the value of fp (for this function) to the pointer that holds the old value of fp.
    add fp, sp, 4
    @ now fp points to the first stack-allocated value that's part of this function (we need to restore sp to that before we leave)
    
    @save the inputs, r0=addr array[0], r1 = address of #decks
    push {r0}
    push {r1}

    @we now need to set the seed of the random num generator.
    mov r0, 0
    bl time
    bl srand

    @ use r4 and r5 for #decks (decks filled) and #cards (cards remaining undealt)

    mov r4, 0
    mov r5, 45

    dealer_loop:
        
        @ do we have cards left? if cards left is 0 or negative (shouldn't be negative though), end the loop
        cmp r5, 0
        ble end_dealer_loop

        @ we need a random number between 1 and cardsLeft, so generate rand and mod by cardsLeft
        @ this will give us 0 through (cardsLeft -1) so add 1
        bl rand
        mov r1, r5
        bl mod
        add r0, r0, 1
        
        @ load the actual array[0] ptr into r2
        @ we know where the stack pointer started (stored in fp), and we stored fp at what is now fp-0, lr in fp-4, r0 in fp-8
        ldr r2, [fp, -8]
        @ now we need to store the contents of r0 in an empty spot in the array. if numDecks = 0, store in array[0]
        @ so we need to calculate the offset by multiplying numDecks by 4 (left shift 2)
        mov r3, r4, LSL #2

        @ store r0 in addr(array) + r3
        str r0, [r2, r3]
        

        @ we need to subtract the cards that went into the new deck (r0) from the remaining undealt cards (r5)
        sub r5, r5, r0
        
        @ and increment the number of decks
        add r4, r4, 1
        @ then loop
        b dealer_loop
    end_dealer_loop:

    @we need to change the value of #decks, which address was passed in and stored as fp-12
    @ load the address from another address
    ldr r3, [fp, -12]
    @ store the number of decks into that address
    str r4, [r3]

    @ deallocate (trash) the values on the stack except for fp and lr
    sub sp, fp, 4
    @ now sp points to fp-4 (the second stack-allocated value in this function, which is lr)
    @ pop lr to pc (returning the program flow to just after this method call), and pop the content at fp as the value of fp. 
    pop {fp, pc}
