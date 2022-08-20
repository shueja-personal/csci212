@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
        .data 
        prompt: .asciz "enter a number: "

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function
main:
        push {fp, lr}
        add fp, sp, 4
        sub sp, sp, 16 @ 12 chars for input, fp-16
        sub sp, sp, 16 @ 12 chars for output, fp -28 
        @ prompt
        ldr r0, =prompt
        bl writeStr

        sub r0, fp, 16
        mov r1, 11
        bl readLn


        sub r0, fp, 16
        bl uDecToInt
        add r1, r0, 1

        sub r0, fp, 28
        bl uIntToDec

        sub r0, fp, 28
        bl writeStr



        sub sp, fp, 4
        pop {fp, pc}

