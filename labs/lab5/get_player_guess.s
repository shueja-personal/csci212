.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data
prompt:  .asciz  "Ask the computer for: "
inp: .asciz "%d"
clearStr: .asciz "%c"

.text
.align 2
.global get_player_guess
.type get_player_guess, %function

get_player_guess:
    push {fp, lr}
    add fp, sp, #4
    mov r0, 0
    push {r0}
    push {r0}
    bl ask

    clear: // only hit this if we know there's stuff in the buffer
    mov r0, 0
    bl getchar
    cmp r0, '\n
    blne clear

    ask:
    ldr r0, =prompt
    bl printf

    ldr r0, =inp
    add r1, fp, -8
    bl scanf
    ldr r0, [fp, -8]

    // if input is outside 1-13, clear input and re-prompt
    cmp r0, 0
    ble clear
    cmp r0, 14
    bge clear

    sub sp, fp, #4
    pop {fp, pc}

