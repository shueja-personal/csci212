@ checkPrime.s
@ Returns 1 if the passed-in number is prime
@ 2017-09-29: Bob Plantz

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Program code
        .text
        .align  2
        .global checkPrimeNumber_asm
        .type   checkPrimeNumber_asm, %function
checkPrimeNumber_asm:

        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        mov     r1, 2           @store j in r1
        mov     r2, 1           @store flag in r2
L1:
        asr     r3, r0, 1       @store n/2 (final value of j) in r3
        cmp     r3, r1
          @if(j<=n/2) //(n/2)-j pos/0
        blmi    allDone
        sdiv    r3, r0, r1                @ divide n by j and store in r3
        mul     r3, r3, r1                  @multiply r3 by j and store in r3
        cmp     r3, r0                        @compare n and r3, if equal go to allDone
        moveq   r2, 0     
        bleq    allDone
        add r1, r1, 1
        bl L1

allDone:
        mov     r0, r2           @ return flag;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return