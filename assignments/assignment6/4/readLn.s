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

        sub     sp, sp, 24       @ space for fp, lr
        str     r4, [sp, 4]     @ save fp
        str     r5, [sp, 8]     @   and lr
        str     r6, [sp, 12]    @r6 is our max length
        str     fp, [sp, 16]
        str     lr, [sp, 20]
        
        add     fp, sp, 20       @ set our frame pointer

        mov r4, r0
        sub r6, r1, 1
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
        bleq    whileLoop // if the character is null, don't increase counter or pointer, just go back to start
        cmp     r5, r6 //characters read - max count >=0, go back to start (overwrite the just-read character)
        bleq    whileLoop

        add r4, r4, 1
        add r5, r5, 1


        bl whileLoop


end:
        mov     r0, 0
        strb    r0, [r4]        // fill the last char with null.
        mov     r0, r5           @ return flag;
        ldr     r4, [sp, 4]     
        ldr     r5, [sp, 8] 
        ldr     r6, [sp, 12]          
        ldr     fp, [sp, 16]     
        ldr     lr, [sp, 20]    
        add     sp, sp, 24      
        bx      lr              @ return