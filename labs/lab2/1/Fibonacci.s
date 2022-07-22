@ Fibonnaci by Jeremiah Shue

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax
	.text
	.align  2
	.global fibonacci
	.type   fibonacci, %function  

fibonacci:                  @ int fibonacci(int num) {
	str     fp, [sp, -4]!   @   // save caller frame pointer
    add     fp, sp, 0       @   // establish our frame pointer

    mov     r1, 0           @   int r1 = 0;
    mov     r2, 1           @   int r2 = 1;
    movs    r3, r0          @   int n = num; // n stored in r3, add s flag to set conditions for r3
                            @   int return; //stored in r0
L1: 
    cmp r3, 2               @   while (n > 1) {     
    bmi L1x
    add r1, r2, r1          @	    r1 = r2 + r1;
    add r2, r1, r2          @	    r2 = r1 + r2; // Fill r1 and r2 with the next two fibonacci numbers.
    sub r3, 2               @	    n-=2;
    b L1                    @   }	
L1x:                        @
    teq r3,0                @   if (n == 0) {
    moveq r0, r1            @	    return = r1;
                            @   }                
    teq r3,1                @   if (n == 1) {
    moveq r0, r2            @	    return = r2;
                            @   }
                            @ 	return r0;  
cleanup:                    @ }
    sub     sp, fp, 0       @ // restore stack pointer
    ldr     fp, [sp], 4     @ // restore caller's frame pointer
    bx      lr              @ // back to caller