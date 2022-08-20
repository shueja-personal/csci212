# Utility file from lecture notes
# I figured it was effectively a given template
.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global mod
.type mod, %function

mod:
   push {fp, lr}
   add fp, sp, #4

   @ mod(r0, r1)

   udiv r2, r0, r1  @ r2 = int(r0/r1)
   mul r2, r2, r1  @ r2 = int(r0/r1)*r1
   sub r2, r0, r2   @ r2 = r0 - int(r0/r1)*r1

   @ return value goes into r0
   mov r0, r2

   sub sp, fp, #4
   pop {fp, pc}
