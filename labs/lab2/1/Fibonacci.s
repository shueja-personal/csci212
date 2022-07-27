@ Fibonnaci by Jeremiah Shue

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax
.data
.string1: .asciz "Enter a number: "
.string2: .asciz "The %dth Fibonacci number is %d\n"
.num1: .word 0
.storage: .space 80
.format: .asciz "%d"

	.text
	.align  2
	.global fibonacci
	.type   fibonacci, %function
    .global main
    .type   main, %function
main:
    push {fp, lr}

    @Input section
    ldr	r0, =.string1 @ load the addr of the string into r0
	@ Call printf
	bl	printf @"enter a number"
    ldr r0, =.format @load the addr of the format string int r0
    ldr r1, =.storage @ load the addr of the buffer
    bl scanf
    ldr r1, =.storage @ load the addr of the buffer to r1 (it got destroyed during scanf)
    ldr r1, [r1]    @ load the contents out of that addr into r1
    ldr r2, =.num1  @ load the addr of the num1 variable into r2
    str r1, [r2, #0]    @ store the contents of r1 into an addr offset 0 from contents of r2

    @Calculation section
    @ Load the inputted value and call fibonacci
    ldr r0, =.num1
    ldr r0, [r0]
    bl fibonacci
    mov r2, r0 //move the return value to be the second parameter of printf
    ldr r1, =.num1
    ldr r1, [r1]
    ldr r0, =.string2
    bl printf

    mov	r0, #0

	@ Clean up memory
    
	@ sp needed
	pop	{fp, pc}

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
