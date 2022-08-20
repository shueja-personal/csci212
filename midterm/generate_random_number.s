        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
        
        .text
        .align 2
        .global generate_random_number
        .type generate_random_number, %function
generate_random_number:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        bl      rand
        mov     r2, #30
        sdiv    r1, r0, r2
        mul     r1, r1, r2
        sub     r0, r0, r1
        add     r0, r0, 10
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
