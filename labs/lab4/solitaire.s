.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
.text
.align 2
.global solitaire
.type solitaire, %function


solitaire:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of array[0] fp-8
    @ r1 = address of #elements fp-12
    push {r0}
    push {r1}
    @ r10 = cardsCollected
    @ r9 = cardsCollected
    @ r8 = decksZeroed
    mov r10, #0
    mov r8, 0
    @ decrement all 
    solitaire_decrement_loop:
        ldr r2, [fp,-12]
        ldr r3, [r2]
        cmp r10, r3
        bge end_solitaire_decrement_loop

        mov r3, r10, LSL #2  @ a[i]
        ldr r4, [r0, r3]
        sub r4, r4, 1
        str r4, [r0, r3]
        cmp r4, 0
        addeq r8, r8, 1

        
        add r10, r10, #1

        b solitaire_decrement_loop

    end_solitaire_decrement_loop:

    push {r8} @ fp-16 = decksZeroed
    push {r10} @fp-20 = cardsCollected

    @ ldr r0, [fp, -8]
    @ ldr r1, [fp, -12]
    @ ldr r1, [r1]
    @ bl      print_array
    @ reconstruct the array with the remaining decks that aren't 0. update the numDecks pointer
    ldr r0, [fp, -8]
    ldr r1, [fp, -12]
    ldr r1, [r1]
    bl      sort_zeroes_up



    @ ldr r0, [fp, -8]
    @ ldr r1, [fp, -12]
    @ ldr r1, [r1]
    @ bl      print_array

    ldr r1, [fp, -12] @ load the numDecks pointer from the stack
    ldr r0, [r1] @ load numDecks
    ldr r8, [fp, -16]
    sub r0, r0, r8
    str r0, [r1]

    ldr r1, [fp, -12] @ load the numDecks pointer from the stack
    ldr r0, [r1] @ load numDecks

    mov r1, r0, LSL 2 @ calculate the offset for the new pile
    ldr r3, [fp, -8] @ load the array pointer
    ldr r2, [fp, -20] @ load the number of cards collected
    str r2, [r3, r1] @ store the new deck

    add r0, r0, 1 @increment numDecks
    ldr r1, [fp, -12] @ load the numDecks pointer from the stack
    str r0, [r1]

    ldr r0, [fp, -8]
    ldr r1, [fp, -12]
    ldr r1, [r1]
    bl      sort_zeroes_up

    sub sp, fp, #4
    pop {fp, pc}
