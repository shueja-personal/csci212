.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
promptStr: .asciz "Enter a character: "
charScan: .asciz "%c"
.text
.equ CHAR_PTR, -8
.align 2
.global get_player_guess
.type get_player_guess, %function

get_player_guess:
    @ r0= character pointer
    push {fp, lr}
    add fp, sp, 4
    push {r0}
    prompt:
    // prompt for a character
    ldr r0, =promptStr
    bl printf
    scan:
    // scanf that character
    ldr r0, =charScan
    ldr r1, [fp, CHAR_PTR]
    bl scanf
    // if it was a newline, scan again without prompt
    ldr r1, [fp, CHAR_PTR]
    ldrb r0, [r1]
    cmp r0, 10
    bleq scan
    // 96 = 'a'-1, 123 = 'z' + 1 (ctype's islower doesn't link correctly)
    // if outside the lowercase letter range, re-prompt
    cmp r0, 96
    ble scan
    cmp r0, 123
    bge scan

    bl end
end:  
    sub sp, fp, 4
    pop {fp, pc}
