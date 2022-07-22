   1              		.arch armv6
   2              		.eabi_attribute 28, 1
   3              		.eabi_attribute 20, 1
   4              		.eabi_attribute 21, 1
   5              		.eabi_attribute 23, 3
   6              		.eabi_attribute 24, 1
   7              		.eabi_attribute 25, 1
   8              		.eabi_attribute 26, 2
   9              		.eabi_attribute 30, 6
  10              		.eabi_attribute 34, 1
  11              		.eabi_attribute 18, 4
  12              		.file	"test.c"
  13              		.text
  14              	.Ltext0:
  15              		.cfi_sections	.debug_frame
  16              		.align	2
  17              		.global	test
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	test:
  24              	.LFB0:
  25              		.file 1 "test.c"
   1:test.c        **** #include <stdio.h>
   2:test.c        **** 
   3:test.c        **** int test(int n)
   4:test.c        **** {
  26              		.loc 1 4 1
  27              		.cfi_startproc
  28              		@ args = 0, pretend = 0, frame = 8
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  32              		.cfi_def_cfa_offset 4
  33              		.cfi_offset 11, -4
  34 0004 00B08DE2 		add	fp, sp, #0
  35              		.cfi_def_cfa_register 11
  36 0008 0CD04DE2 		sub	sp, sp, #12
  37 000c 08000BE5 		str	r0, [fp, #-8]
   5:test.c        **** 	return (n % 10);
  38              		.loc 1 5 12
  39 0010 08201BE5 		ldr	r2, [fp, #-8]
  40 0014 34309FE5 		ldr	r3, .L3
  41 0018 9312C3E0 		smull	r1, r3, r3, r2
  42 001c 4311A0E1 		asr	r1, r3, #2
  43 0020 C23FA0E1 		asr	r3, r2, #31
  44 0024 031041E0 		sub	r1, r1, r3
  45 0028 0130A0E1 		mov	r3, r1
  46 002c 0331A0E1 		lsl	r3, r3, #2
  47 0030 013083E0 		add	r3, r3, r1
  48 0034 8330A0E1 		lsl	r3, r3, #1
  49 0038 031042E0 		sub	r1, r2, r3
  50 003c 0130A0E1 		mov	r3, r1
   6:test.c        **** }
  51              		.loc 1 6 1
  52 0040 0300A0E1 		mov	r0, r3
  53 0044 00D08BE2 		add	sp, fp, #0
  54              		.cfi_def_cfa_register 13
  55              		@ sp needed
  56 0048 04B09DE4 		ldr	fp, [sp], #4
  57              		.cfi_restore 11
  58              		.cfi_def_cfa_offset 0
  59 004c 1EFF2FE1 		bx	lr
  60              	.L4:
  61              		.align	2
  62              	.L3:
  63 0050 67666666 		.word	1717986919
  64              		.cfi_endproc
  65              	.LFE0:
  67              		.section	.rodata
  68              		.align	2
  69              	.LC0:
  70 0000 54686520 		.ascii	"The digit in the ones place of %d is %d\012\000"
  70      64696769 
  70      7420696E 
  70      20746865 
  70      206F6E65 
  71              		.text
  72              		.align	2
  73              		.global	main
  74              		.syntax unified
  75              		.arm
  76              		.fpu vfp
  78              	main:
  79              	.LFB1:
   7:test.c        **** 
   8:test.c        **** int main(int argc, char *argv[]) {
  80              		.loc 1 8 34
  81              		.cfi_startproc
  82              		@ args = 0, pretend = 0, frame = 16
  83              		@ frame_needed = 1, uses_anonymous_args = 0
  84 0054 00482DE9 		push	{fp, lr}
  85              		.cfi_def_cfa_offset 8
  86              		.cfi_offset 11, -8
  87              		.cfi_offset 14, -4
  88 0058 04B08DE2 		add	fp, sp, #4
  89              		.cfi_def_cfa 11, 4
  90 005c 10D04DE2 		sub	sp, sp, #16
  91 0060 10000BE5 		str	r0, [fp, #-16]
  92 0064 14100BE5 		str	r1, [fp, #-20]
   9:test.c        ****     int i = 294;
  93              		.loc 1 9 9
  94 0068 2C309FE5 		ldr	r3, .L7
  95 006c 08300BE5 		str	r3, [fp, #-8]
  10:test.c        **** 
  11:test.c        ****     printf("The digit in the ones place of %d is %d\n", i, test(i));
  96              		.loc 1 11 5
  97 0070 08001BE5 		ldr	r0, [fp, #-8]
  98 0074 FEFFFFEB 		bl	test
  99 0078 0030A0E1 		mov	r3, r0
 100 007c 0320A0E1 		mov	r2, r3
 101 0080 08101BE5 		ldr	r1, [fp, #-8]
 102 0084 14009FE5 		ldr	r0, .L7+4
 103 0088 FEFFFFEB 		bl	printf
  12:test.c        ****     
  13:test.c        ****     return 0;
 104              		.loc 1 13 12
 105 008c 0030A0E3 		mov	r3, #0
  14:test.c        **** }
 106              		.loc 1 14 1
 107 0090 0300A0E1 		mov	r0, r3
 108 0094 04D04BE2 		sub	sp, fp, #4
 109              		.cfi_def_cfa 13, 8
 110              		@ sp needed
 111 0098 0088BDE8 		pop	{fp, pc}
 112              	.L8:
 113              		.align	2
 114              	.L7:
 115 009c 26010000 		.word	294
 116 00a0 00000000 		.word	.LC0
 117              		.cfi_endproc
 118              	.LFE1:
 120              	.Letext0:
