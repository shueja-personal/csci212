@ GCD by Jeremiah Shue

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax
	.text
	.align  2
	.global gcd
	.type   gcd, %function

gcd:
	str     fp, [sp, -4]!   @   // save caller frame pointer
    add     fp, sp, 0       @   // establish our frame pointer

    
    mov     r3, r1           @   //a is in r2, b is in r3
    mov     r2, r0          
L1: 
    teq r2, 0                    
    beq cleanup
    cmp r3,r2

    eorpl r2, r2, r3        @ swap
    eorpl r3, r2, r3
    eorpl r2, r2, r3

    sdiv r1, r2, r3
    mul r1, r1, r3
    sub r2, r2, r1
    b L1

cleanup:                    
    mov r0, r3
    sub     sp, fp, 0       @ // restore stack pointer
    ldr     fp, [sp], 4     @ // restore caller's frame pointer
    bx      lr              @ // back to caller