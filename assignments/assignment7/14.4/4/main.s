@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

.data
        prompt: .asciz "Enter up to 32-bit hex number: "
        reply: .asciz "The sum is: %i\n"
@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        push {fp, lr}
        add     fp, sp, 4
        push {r4}
        push {r5}
        push {r6}

        mov r0, 9
        bl malloc
        mov r4, r0

        mov r0, 9
        bl malloc
        mov r5, r0

        ldr r0, =prompt
        bl writeStr
        mov r0, r4
        mov r1, 9
        bl readLn

        ldr r0, =prompt
        bl writeStr
        mov r0, r5
        mov r1, 9
        bl readLn

        mov r0, r4
        bl hexToInt
        mov r6, r0

        mov r0, r5
        bl hexToInt
        add r1, r0, r6

        ldr r0, =reply
        bl printf
        mov r0, r4
        bl free
        mov r0, r5
        bl free
        pop {r6}
        pop {r5}
        pop {r4}

        sub   sp, fp, 4
        pop {fp, pc}
        