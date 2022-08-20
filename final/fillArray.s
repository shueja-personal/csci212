.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data

.text
.align 2
.global fillByteArray
.type fillByteArray, %function

fillByteArray:
    push {fp, lr}
    add fp, sp, 4
    @r0, array addr
    @r1, size
    @r2, value
    push {r4}

    mov r3, 0
    fill_loop:
        cmp r3, r1
        bge end_fill_loop
        strb r2, [r0, r3]
        add r3, r3, 1
        b fill_loop
    end_fill_loop:
    pop {r4}
    sub fp, sp, 4
    pop {fp, pc}
