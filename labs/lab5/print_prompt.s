.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data
computer:  .asciz  "Computer: "
player: .asciz "Player: "

.text
.align 2
.global print_computer
.type print_computer, %function
.global print_player
.type print_player, %function
.global print_prompt
.type print_prompt, %function


print_prompt:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = 0 for computer, 1
    @ r1 = #decks
    mov r4, r0

    @ for (i = 0; i < r5; i++)
    @ printf("%d\n", array[i])
    cmp r4, 0
    ldreq r0, =computer
    ldrne r0, =player
    bl printf

    mov r0, 0

    sub sp, fp, #4
    pop {fp, pc}

print_computer:
    push {fp, lr}
    add fp, sp, #4
    mov r0, 0
    bl print_prompt
    sub sp, fp, #4
    pop {fp, pc}

print_player:
    push {fp, lr}
    add fp, sp, #4
    mov r0, 1
    bl print_prompt
    sub sp, fp, #4
    pop {fp, pc}
