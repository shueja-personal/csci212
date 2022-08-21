.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.text
.align 2
.global random_number
.type random_number, %function
random_number: 
    push {fp, lr}
    add fp, sp, 4
    push {r0}
    bl rand
    pop {r1}
    bl mod
    sub sp, fp, 4
    pop {fp, pc}
