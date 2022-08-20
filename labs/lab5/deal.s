
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data
outp:  .asciz  "%d "
newline: .asciz "\n"

.text
.align 2
.global deal
.type deal, %function
.global draw
.type draw, %function

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

deal:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of deck
    @ r1 = address of hand
    push {r0}
    push {r1}
    
    mov r10, 0
    push {r10}


    @ for (i = 0; i < r5; i++)
    @ printf("%d\n", array[i])

    deal_loop:
        ldr r10, [fp,-16]
        cmp r10, 7
        bge end_deal_loop

        ldr r0, [fp, -8]
        ldr r1, [fp, -12]
        bl draw

        ldr r10, [fp,-16]
        add r10, r10, #1
        str r10, [fp,-16]
        b deal_loop

    end_deal_loop:
    pop {r10}
    sub sp, fp, #4
    pop {fp, pc}

draw:
push {fp, lr}
    add fp, sp, #4
    @ r0 = address of deck
    @ r1 = address of hand
    push {r0}
    push {r1}


    @ for (i = 0; i < r5; i++)
    @ printf("%d\n", array[i])

    draw_loop:
        ldr r0, [fp, -8]
        bl checkEmpty
        cmp r0, 1
        moveq r0, 0
        bleq end_draw_loop

        bl rand
        mov r1, 13
        bl mod
        // r0 has idx
        mov r2, r0
        mov r3, r2, LSL #2
        @ if (0-deck[idx] >= 0) {
        @    continue;
        @}
        ldr r1, [fp, -8]
        ldr r0, [r1, r3]
        cmp r0, 0
        beq draw_loop

        ldr r0, [r1, r3]
        sub r0, r0, 1
        str r0, [r1, r3]

        ldr r1, [fp, -12]
        ldr r0, [r1, r3]
        add r0, r0, 1
        str r0, [r1, r3]

        lsr r0, r3, 2
        add r0, r0, 1

    end_draw_loop:
    sub sp, fp, #4
    pop {fp, pc}
