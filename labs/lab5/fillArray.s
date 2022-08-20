.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data

.text
.align 2
.global fillArray
.type fillArray, %function

fillArray:
    push {fp, lr}
    add fp, sp, 4
    @r0, array addr
    @r1, size
    @r2, value
    push {r4}

    mov r3, 0
    mov r1, r1, lsl 2
    init_deck_loop:
        cmp r3, r1
        bge end_init_deck_loop
        str r2, [r0, r3]
        add r3, r3, 4
        b init_deck_loop
    end_init_deck_loop:
    pop {r4}
    sub fp, sp, 4
    pop {fp, pc}
