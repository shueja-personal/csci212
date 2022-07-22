	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"test.c"
	.text
	.align	2
	.global	test
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	test, %function
	@ the include statement and test method declaration
test:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	@ Set the frame pointer correctly and store the parameter n in register 0
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	@ perform the mod by 10
	@ load n into register 2
	ldr	r2, [fp, #-8]
	@ load the data labeled .L3 into r3 (data is decimal 1717986919, 
	@ binary 0110 0110 0110 0110 0110 0110 0110 0111. I think this has something to do
	@ with the operand of 10 [1010] in the C code)
	ldr	r3, .L3
	@ multiplies n times .L3 and
	@ stores the most significant 32 bits in r3 and the least significant in r1
	smull	r1, r3, r3, r2
	@ right-shifts the most significant 32 bits by 2 bits,
	@ filling those two bits with the sign bit of the product and stores it in r1
	@ overwriting the least significant
	asr	r1, r3, #2
	@ rightshifts n by 31 bits 
	@ (fills the gap with the msb of n)
	@ and stores the result in r3, giving us 32 bits of only the MSB of n (the sign bit)
	@ This will be all 1s for negative numbers and all 0s for positive/0 
	asr	r3, r2, #31
	@ negates (bitflip) and adds the sign bit mask from the shifted most significant 32 bits
	@ and overwrites r1
	sub	r1, r1, r3
	@ 
	mov	r3, r1
	@ Divides r3 by 4 and stores in r3
	lsl	r3, r3, #2
	@ I'm not sure how this shifting accomplishes a divide by 10, though 
	add	r3, r3, r1
	lsl	r3, r3, #1
	sub	r1, r2, r3
	mov	r3, r1
	@ move the return value to r0 and move the frame pointer
	@ back to the main method just after the "test" call
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L4:
	.align	2
.L3:
	.word	1717986919
	.size	test, .-test
	.section	.rodata
	.align	2
.LC0:
	.ascii	"The digit in the ones place of %d is %d\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	@ load the constant 294 into r3, then store it 8 bytes behind the frame pointer
	ldr	r3, .L7
	
	str	r3, [fp, #-8]
	@ Put the constant into r0 to be read into the test method
	ldr	r0, [fp, #-8]
	@ Call the test method
	bl	test
	@ Move the output of test into r2
	mov	r3, r0
	mov	r2, r3
	@ Load the original constant (294) from 8 bytes behind the frame pointer
	ldr	r1, [fp, #-8]
	@ Load the address of the text into r0
	ldr	r0, .L7+4
	@ Call printf
	bl	printf
	mov	r3, #0
	@ Clean up memory
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	294
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Raspbian 10.2.1-6+rpi1) 10.2.1 20210110"
	.section	.note.GNU-stack,"",%progbits
