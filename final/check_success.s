.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
promptStr: .asciz "Enter a character: "
charScan: .asciz "%c"
.text
.equ WORD_PTR, -8
.equ GUESS_WORD_PTR, -12
.equ IDX, -16
.align 2
.global check_success
.type check_success, %function

check_success:
@ r0= word pointer
@ r1= guessWord pointer
    push {fp, lr}
    add fp, sp, 4
    push {r0}
    push {r1}
    mov r2, 0
    push {r2} // make space for idx
    mov r0, 1 // flag

loop: 
    ldr r2, [fp, WORD_PTR]
    ldr r3, [fp, IDX]
    ldrb r2, [r2, r3] // load character from secret word
    cmp r2, 0 // if null, end (using the initial 1 as return)
    beq end

    ldr r1, [fp, GUESS_WORD_PTR]
    ldr r3, [fp, IDX]
    ldrb r1, [r1, r3] // load character from guessed word
    cmp r2, r1 // if it does not match the secret word
    movne r0, 0 // set flag to 0
    bne end // end
    repeat:
    ldr r3, [fp, IDX]
    add r3, r3, 1
    str r3, [fp, IDX]
    b loop
end:
    sub sp, fp, 4
    pop {fp, pc}
