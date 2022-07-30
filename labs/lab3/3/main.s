@ checkPrime.s
@ Returns 1 if the passed-in number is prime
@ 2017-09-29: Bob Plantz

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
.data
text1:
    .asciz "Enter two positive integers: "
formatin:
    .asciz "%d %d"
text2:
    .asciz "Prime numbers between %d and %d are: "
formatout:
    .asciz "%d "
n1: .word 0
n2: .word 0

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function


main:

        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        ldr r0, =text1
        bl printf

        ldr r0, =formatin
        ldr r1, =n1
        ldr r2, =n2
        bl scanf

        ldr r0, =text2
        ldr r1, =n1
        ldr r1, [r1]
        ldr r2, =n2
        ldr r2, [r2]
        bl printf

        ldr r1, =n1
        ldr r1, [r1]
        add r1, r1, 1

L1:
        // i = n1+1
        ldr r1, =n1
        ldr r1, [r1]
        add r1, r1, 1
        ldr r2, =n1
        str r1, [r2, #0]
        //i<n2
        ldr     r3, =n2       @store n/2 (final value of j) in r3
        ldr     r3, [r3]
        cmp     r1, r3
        blpl    allDone
        mov     r0, r1
        bl      checkPrimeNumber_asm
        cmp     r0, 1
        ldreq   r0, =formatout
        ldreq r1, =n1
        ldreq r1, [r1]
        bleq printf
        bl L1

allDone:
        mov     r0, 0           @ return flag;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return