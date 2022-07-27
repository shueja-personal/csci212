@ f.s
@ returns 0
@ based on textbook code

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Program code
        .text
        .align  2
        .global g
        .type   g, %function
g:
        str     fp, [sp, -4]!   @ save caller frame pointer
        add     fp, sp, 0       @ establish our frame pointer

        ldr     r0, =num          @ return values go in r0
        ldr     r0, [r0]


        sub     sp, fp, 0       @ restore stack pointer
        ldr     fp, [sp], 4     @ restore caller's frame pointer
        bx      lr              @ back to caller
.data
num: .word 123 @ sorry I still don't like having magic numbers in code