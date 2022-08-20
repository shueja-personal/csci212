
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

.data
outp:  .asciz  "%d "
newline: .asciz "\n\n"
score: .asciz " | You: %d | Computer: %d"

.text
.align 2
.global print_hud
.type print_hud, %function


print_hud:
    push {fp, lr}
    add fp, sp, #4
    push {r0, r1, r2, r10} // 44 bytes
    @ r0 = address of array[0]
    @ r1 = yourScore*
    @ r2 = computerScore*

    @ r10 = i
    mov r10, #0
    push {r10}
    @ fp, lr, 10, 2, 1, 0, i


    print_array_loop:
        ldr r10, [fp, -24]
        cmp r10, 13
        bge end_print_array_loop

        
        mov r3, r10, LSL #2
        ldr r0, [fp, -20]
        ldr r1, [r0, r3]
        ldr r0, =outp

        cmp r1, 0
        addne r1, r10, 1
        
        blne printf

        ldr r10, [fp, -24]
        add r10, r10, #1
        str r10, [fp, -24]

        b print_array_loop

    end_print_array_loop:

    ldr r0, =score
    ldr r1, [fp,-16]
    ldr r1, [r1]
    ldr r2, [fp, -12]
    ldr r2, [r2]
    bl printf

    ldr r0, =newline
    bl printf
    pop {r0, r1, r2, r10}
    sub sp, fp, #4
    pop {fp, pc}
