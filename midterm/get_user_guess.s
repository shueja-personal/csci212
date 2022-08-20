        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
        .data
prompt: .asciz "Enter a number: "
format: .asciz "%d"
        .text
        .align 2
        .global get_user_guess
        .type get_user_guess, %function
get_user_guess:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, 8
        mov     r0, 29
        str     r0, [sp, 4]
        ldr     r0, =prompt
        bl      printf

        ldr     r0, =format
        add     r1, sp, 4       @load the pointer on the stack
        bl      scanf

        ldr     r0, [sp, 4]
        add     sp, sp, 8
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
