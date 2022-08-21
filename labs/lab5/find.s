.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.text
.align 2
.global pick_random
.type pick_random, %function
.global get
.type get, %function

pick_random:
    push {fp, lr}
    add fp, sp, 4

    push {r0} @ deck
    draw_loop:
        // gen random number
        
        mov r0, 13
        bl random_number
        // r0 has idx
        push {r0}
        ldr r0, [fp, -8]
        pop {r1}
        bl get

        cmp r0, 0
        beq draw_loop
    end_draw_loop:

    mov r0, r1

    sub sp, fp, 4
    pop {fp, pc}

get:
    @r0: deck
    @r1: card (0-12)
    push {fp, lr}
    add fp, sp, 4
    mov r3, r1, LSL #2
    ldr r0, [r0, r3]
    sub sp, fp, 4
    pop {fp, pc}
