@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
@ Program code
        .text
        .align  2
        .global readLn
        .type   readLn, %function



readLn:

        sub     sp, sp, 16       @ space for fp, lr
        str     r4, [sp, 0]     @ save fp
        str     r5, [sp, 4]     @   and lr
        str     fp, [sp, 8]
        str     lr, [sp, 12]
        add     fp, sp, 12       @ set our frame pointer

        mov r4, r0
        mov r5, 0
whileLoop:
        mov     r0, 0 @stdin
        mov     r1, r4
        mov     r2, 1
        bl      read
        ldrb    r0, [r4]
        cmp     r0, 10
        bleq    end // if the character is lf, don't increase counter or pointer (we'll overwrite with null)
        cmp     r0, 0 
        bleq    end // if the character is null, don't increase counter or pointer

        add r4, r4, 1
        add r5, r5, 1
        bl whileLoop


end:
        mov     r0, 0
        strb    r0, [r4]        // fill the last char with null.
        mov     r0, r5           @ return flag;
        ldr     r4, [sp, 0]     
        ldr     r5, [sp, 4]           
        ldr     fp, [sp, 8]     
        ldr     lr, [sp, 12]    
        add     sp, sp, 16      
        bx      lr              @ return
