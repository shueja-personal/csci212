
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data
outp:  .asciz  "%d "
newline: .asciz "\n"

.text
.align 2
.global checkEmpty
.type checkEmpty, %function


checkEmpty:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of deck
    mov r4, r0
    @ r5, return value (0=not empty, 1= empty)
    mov r5, 1
    @ r10 = i
    mov r10, 0

    checkEmpty_loop:
        cmp r10, 13
        movge r5, 1 // if we got to the end, return 1 (the deck is empty)
        bge end_checkEmpty_loop
        mov r3, r10, LSL #2
        ldr r0, [r4, r3]
        cmp r0, 0
        movne r5, 0 // if we find an element that's not 0, return 0
        bne end_checkEmpty_loop

        add r10, r10, #1

        b checkEmpty_loop

    end_checkEmpty_loop:
    mov r0, r5
    sub sp, fp, #4
    pop {fp, pc}
