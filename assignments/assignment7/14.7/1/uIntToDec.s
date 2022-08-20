@ uIntToDec.s
@ Converts an int to the corresponding unsigned
@ decimal text string.
@ Calling sequence:
@       r0 <- address of place to store string
@       r1 <- int to convert
@       bl uIntToDec
@ 2017-09-29: Bob Plantz

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    tempString,-32  @ for temp string
        .equ    locals,16       @ space for local vars
        .equ    zero,0x30       @ ascii 0
        .equ    NUL,0

@ The program
        .text
        .align  2
        .global uIntToDec
        .type   uIntToDec, %function
uIntToDec:
        sub     sp, sp, 24      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     r6, [sp, 8]     @      r6
        str     r7, [sp, 12]    @      r7
        str     fp, [sp, 16]    @      fp
        str     lr, [sp, 20]    @      lr
        add     fp, sp, 20      @ set our frame pointer
        sub     sp, sp, locals  @ for local vars
        
        mov     r4, r0          @ caller's string pointer
        add     r5, fp, tempString @ temp string
        mov     r7, 10          @ decimal constant
        
        mov     r0, NUL         @ end of C string
        strb    r0, [r5]
        add     r5, r5, 1       @ move to char storage

        mov     r0, zero        @ assume the int is 0
        strb    r0, [r5]
        movs    r6, r1          @ int to convert
        beq     copyLoop        @ zero is special case
convertLoop:
        cmp     r6, 0           @ end of int?
        beq     copy            @ yes, copy for caller
        udiv    r0, r6, r7      @ no, div to get quotient
        mul     r1, r0, r7      @ need for computing remainder
        sub     r2, r6, r1      @ the mod (remainder)
        mov     r6, r0          @ the quotient
        orr     r2, r2, zero    @ convert to numeral
        strb    r2, [r5]
        add     r5, r5, 1       @ next char position
        b       convertLoop
copy:
        sub     r5, r5, 1       @ last char stored locally
copyLoop:
        ldrb    r0, [r5]        @ get local char
        strb    r0, [r4]        @ store the char for caller
        cmp     r0, NUL         @ end of local string?
        beq     allDone         @ yes, we're done
        add     r4, r4, 1       @ no, next caller location
        sub     r5, r5, 1       @ next local char
        b       copyLoop
        
allDone:        
        strb    r0, [r4]        @ end C string
        add     sp, sp, locals  @ deallocate local var
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @      r5
        ldr     r6, [sp, 8]     @      r6
        ldr     r7, [sp, 12]    @      r7
        ldr     fp, [sp, 16]    @      fp
        ldr     lr, [sp, 20]    @      lr
        add     sp, sp, 24      @      sp
        bx      lr              @ return
        