@ digitPrinter.s
@ Prints the digits from 0 to 9
@ 2017-09-29: Bob Plantz

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Useful source code constants
        .equ    STDIN,0
        .equ    STDOUT,1
        .equ    local, 8

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 16       @ space for fp, lr, and r4
        str     r4, [sp, 4]
        str     fp, [sp, 8]     @ save fp
        str     lr, [sp, 12]     @   and lr
        add     fp, sp, 12       @ set our frame pointer
        sub     sp, sp, local   @ allocate memory for local var
    
        mov     r4, #'0'
L1:
        mov     r0, STDOUT      @ prompt user for input
        strb     r4, [fp, -20]
        add     r1, fp, -20
        
        mov     r2, 1
        
        bl      write
        add   r4, r4, 1
        cmp     r4, '9'
        
        ble      L1
      

        mov     r0, 0           @ return 0;
        add     sp, sp, local
        ldr     r4, [sp, 4]
        ldr     fp, [sp, 8]     @ restore caller fp
        ldr     lr, [sp, 12]     @       lr
        add     sp, sp, 16       @   and sp
        bx      lr              @ return
