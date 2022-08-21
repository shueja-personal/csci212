.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.text
.align 2
.global random
.type random, %function
random: 
    push {fp, lr}
    add fp, sp, 4
    push {r0}
    bl rand
    pop {r1}
    bl mod
    sub sp, fp, 4
    pop {fp, pc}
