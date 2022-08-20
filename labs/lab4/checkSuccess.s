
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.text
.align 2
.global check_success
.type check_success, %function


check_success:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of array[0]
    @ r1 = #decks
    mov r4, r0
    mov r5, 9

    @ r10 = i
    mov r10, 0

    @ for (i = 0; i < r5; i++)
    @ printf("%d\n", array[i])
    mov r0, 1
    check_success_loop:
        cmp r10, r5
        bge end_check_success_loop

        
        mov r3, r10, LSL #2
        ldr r1, [r4, r3]
        sub r1, r1, 1
        cmp r10, r1
        movne r0, 0

        
        

        add r10, r10, #1

        b check_success_loop

    end_check_success_loop:


    sub sp, fp, #4
    pop {fp, pc}
