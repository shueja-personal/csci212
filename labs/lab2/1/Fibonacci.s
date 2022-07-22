@ Fibonnaci by Jeremiah Shue

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax
	.text
	.align  2
	.global fibonacci
	.type   fibonacci, %function  

fibonacci:                  @ int fibonacci(int r0) {
	str     fp, [sp, -4]!   @   save caller frame pointer
    add     fp, sp, 0       @   establish our frame pointer

    mov     r1, 0           @   int r1 = 1;
    mov     r2, 1           @   int r2 = 0;
    movs    r3, r0          @   int n = r0; // n stored in r3, add s flag to set conditions for r3

L1: 
    cmp r3,2                @   while (n > 1) {     
    bmi L1x
    add r1, r2, r1          @	    r1 = r2 + r1;
    add r2, r1, r2          @	    r2 = r1 + r2;
    sub r3, 2               @	    n-=2;
    b L1                    @   }	
L1x:                        @
    teq r3,0
    @bne L2                  @   if (n == 0) {
    moveq r0, r1              @	    r0 = r1;
L2:                         @   }
    teq r3,1                
    @bne L3                  @   if (n == 1) {
    moveq r0, r2              @	    r0 = r2;
L3:                         @   }
                            @	return r0;
                            @   
cleanup:                    @ }
    sub     sp, fp, 0       @ restore stack pointer
    ldr     fp, [sp], 4     @ restore caller's frame pointer
    bx      lr              @ back to caller