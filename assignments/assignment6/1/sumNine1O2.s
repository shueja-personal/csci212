	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"sumNine1.c"
	.text
	.align	2
	.global	sumNine
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	sumNine, %function
sumNine:
	@ args = 20, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	add	r1, r0, r1
	str	lr, [sp, #-4]!
	add	r2, r1, r2
	add	r3, r2, r3
	ldr	r2, [sp, #4]
	ldr	lr, [sp, #8]
	ldr	ip, [sp, #12]
	add	r3, r3, r2
	ldr	r1, [sp, #16]
	add	r3, r3, lr
	ldr	r0, [sp, #20]
	add	r3, r3, ip
	add	r3, r3, r1
	add	r0, r3, r0
	ldr	pc, [sp], #4
	.size	sumNine, .-sumNine
	.ident	"GCC: (Raspbian 10.2.1-6+rpi1) 10.2.1 20210110"
	.section	.note.GNU-stack,"",%progbits
