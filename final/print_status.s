.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
out: .asciz "%s\n\n%s\n\nMissing letters: %s\n\n"
.text
.align 2
.global print_status
.type print_status, %function

print_status:
    push {fp, lr}
    add fp, sp, 4
    push {r0, r1, r2}
    pop {r1, r2, r3}
    ldr r0, =out
    bl printf
    mov r0, 0
    sub sp, fp, 4
    pop {fp, pc}
