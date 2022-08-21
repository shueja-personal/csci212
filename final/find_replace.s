.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
.text
.equ WORD_PTR, -8
.equ GUESS_WORD_PTR, -12
.equ CHAR_PTR, -16
.equ IDX, -20

.align 2
.global find_replace
.type find_replace, %function

find_replace:
@ r0= word pointer
@ r1= guessWord pointer
@ r2= character being searched
    push {fp, lr}
    add fp, sp, 4
    push {r0}
    push {r1}
    push {r2}
    mov r2, 0
    push {r2} // space for idx
    mov r0, 1 // flag

loop: 
    ldr r2, [fp, WORD_PTR]
    ldr r3, [fp, IDX]
    ldrb r2, [r2, r3] // load character in word
    cmp r2, 0 // if null, end
    beq end

    ldrb r1, [fp, CHAR_PTR]
    cmp r2, r1 // compare character in word with search character
    bne repeat // if not equal increment idx and repeat
    // if it is equal...
    ldr r2, [fp, GUESS_WORD_PTR]
    ldr r3, [fp, IDX]
    strb r1, [r2, r3] // store the search character in the guess word, replacing a dash
    mov r0, 0
    repeat:
    ldr r3, [fp, IDX]
    add r3, r3, 1
    str r3, [fp, IDX]
    b loop
end:
    sub sp, fp, 4
    pop {fp, pc}
