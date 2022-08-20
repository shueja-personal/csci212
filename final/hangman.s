.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
hangman: .asciz "HANGMAN"
.text
.align 2
.global advance_hangman
.type advance_hangman, %function

advance_hangman:
    push {fp, lr}
    add fp, sp, 4
    mov r3, 0
    @ r0 - array of missed letters
    @ r1 - character to add
    loop:

        cmp r3, 7
        movge r0, 0
        bge end
        ldrsb r2, [r0, r3]

        cmp r2, '\0
        moveq r0, 1
        beq end


        cmp r2, '-
        ldreq r2, =hangman
        ldrbeq r1, [r2, r3]
        strbeq r1, [r0, r3]
        moveq r0, 1
        beq end
        add r3, r3, 1
        b loop
    end:
    sub sp, fp, 4
    pop {fp, pc}
