        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
        .data
youGotIt: .asciz "You got it! The number was %d and it took %d guesses\n"
tooLow: .asciz "Too low\n"
tooHigh: .asciz "Too high\n"
youLost: .asciz "Sorry! The number was %d\n"
        .text
        .align 2
        .global main
        .type main, %function
main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, 8       // space for i and n

        mov     r0, 0           //set seed: srand(time(0))
        bl      time     
        bl      srand

        mov     r0, 0           @ store i =0 in sp+0
        str     r0, [sp, 0]

        bl      generate_random_number
        str     r0, [sp, 4]     @ store the random number in sp+4
L1:
        ldr     r0, [sp, 0]     @ load i and see if we're out of guesses
        mov     r1, 5
        cmp     r0, r1
        blpl    printFail

        bl      get_user_guess @ get the guess
        ldr     r1, [sp,4] @ cmp with the random number
        @ this also puts the number in r1 for the print later
        cmp     r1, r0
        
        bleq    printSuccess
        ldrpl   r0, =tooLow // if positive or 0, print too low
        ldrmi   r0, =tooHigh
        bl      printf
        
        @ increment i
        ldr     r0, [sp, 0]
        add     r0, r0, 1
        str     r0, [sp, 0]
        bl      L1

printFail:      
        ldr     r0, =youLost
        ldr     r1, [sp, 4]
        bl      printf
        bl      allDone
printSuccess:
        ldr     r0, =youGotIt
        ldr     r1, [sp, 4]
        ldr     r2, [sp, 0]
        bl      printf
allDone:
        mov     r0, 0
        add     sp, sp, 8
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
    