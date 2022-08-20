 @ uDecToInt.s
@ Converts a decimal text string to an unsigned int.
@ Calling sequence:
@       r0 <- address of string
@       bl uDecToInt
@ returns equivalent int
@ 2017-09-29: Bob Plantz

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler

@ The program
        .text
        .align  2
        .global getDecInt
        .type   getDecInt, %function
getDecInt:
    @ read line
    @ if begins with '-' set negative flag
    push {fp, lr}
    add fp, sp, 4
    

        