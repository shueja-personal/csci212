@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

.data
text1:
    .asciz "Hello World!"
@ Program code
        .text
        .align  2
        .global writeStr
        .type   writeStr, %function
        .global main
        .type   main, %function

main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        ldr     r0, =text1
        bl      writeStr
        mov     r0, 0           @ return flag;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

writeStr:

        sub     sp, sp, 16       @ space for fp, lr
        str     r4, [sp, 0]     @ save fp
        str     r5, [sp, 4]     @   and lr
        str     fp, [sp, 8]
        str     lr, [sp, 12]
        add     fp, sp, 12       @ set our frame pointer

        mov r4, r0
        mov r5, 0
whileLoop:
        ldrb    r0, [r4]
        cmp     r0, 0
        bleq    end
        mov     r0, 1 @stdout
        mov     r1, r4
        mov     r2, 1
        bl write

        add r4, r4, 1
        add r5, r5, 1
        bl whileLoop


end:
        mov     r0, r5           @ return flag;
        ldr     r4, [sp, 0]     
        ldr     r5, [sp, 4]           
        ldr     fp, [sp, 8]     
        ldr     lr, [sp, 12]    
        add     sp, sp, 16      
        bx      lr              @ return