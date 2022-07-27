@ GCD by Jeremiah Shue

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

.data
.string1:
    .ascii "Enter the first number: \012\000"

.string2:
    .ascii "Enter the second number: \012\000"

.string3:
	.ascii	"The gcd is %d\012\000"

.format:
    .asciz  "%d"

.num1:
    .word 0
.num2:
    .word 0
.storage: 
    .space 80
.text
	.global gcd
	.type   gcd, %function
    .global main
    .type   main, %function

main:
    push	{fp, lr}
    @First input section
	
	ldr	r0, =.string1
	@ Call printf
	bl	printf @"enter the first number"
    ldr r0, =.format
    ldr r1, =.storage
    bl scanf
    ldr r1, =.storage 
    ldr r1, [r1]    
    ldr r2, =.num1  
    str r1, [r2, #0]    

    @Second input section

    ldr	r0, =.string2 @ load the addr of the string into r0
	@ Call printf
	bl	printf @"enter the second number"
    ldr r0, =.format @load the addr of the format string int r0
    ldr r1, =.storage @ load the addr of the buffer
    bl scanf
    ldr r1, =.storage @ load the addr of the buffer to r1 (it got destroyed during scanf)
    ldr r1, [r1]    @ load the contents out of that addr into r1
    ldr r2, =.num2  @ load the addr of the num1 variable into r2
    str r1, [r2, #0]    @ store the contents of r1 into an addr offset 0 from contents of r2

    @ Load the inputted values and call gcd
    ldr r0, =.num1
    ldr r0, [r0]
    ldr r1, =.num2
    ldr r1, [r1]
    bl gcd
    mov r1, r0 //move the return value to be the second parameter of printf
    ldr r0, =.string3
    bl printf
	mov	r0, #0

	@ Clean up memory
    
	@ sp needed
	pop	{fp, pc}

gcd:
	str     fp, [sp, -4]!   @   // save caller frame pointer
    add     fp, sp, 0       @   // establish our frame pointer

    
    mov     r3, r1           @   //a is in r2, b is in r3
    mov     r2, r0          
L1: 
    teq r2, 0                 @ if b ==0   
    beq cleanup                 @jump to cleanup, otherwise...
    cmp r3,r2                  @ eval b-a and set condition flags

    eorpl r2, r2, r3        @ swap if b-a is positive
    eorpl r3, r2, r3
    eorpl r2, r2, r3

    sdiv r1, r2, r3         @divide a/b and store in r1
    mul r1, r1, r3          @ multiply r1 by b and store in r1 (which now holds the greatest mult of b less than a)
    sub r2, r2, r1          @ subtract r1 from a to get the remainder
    b L1                    @ return to top, where b and a will swap again

cleanup:                    
    mov r0, r3              @ return b after we break the loop
    sub     sp, fp, 0       @ // restore stack pointer
    ldr     fp, [sp], 4     @ // restore caller's frame pointer
    bx      lr              @ // back to callerx


