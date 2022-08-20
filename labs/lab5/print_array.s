
.cpu cortex-a53
.fpu neon-fp-armv8

.data
outp:  .asciz  "%d "
newline: .asciz "\n"

.text
.align 2
.global print_array
.type print_array, %function


print_array:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of array[0]
    @ r1 = #decks
    mov r4, r0
    mov r5, r1

    @ r10 = i
    mov r10, #0

    @ for (i = 0; i < r5; i++)
    @ printf("%d\n", array[i])

    print_array_loop:
        cmp r10, r5
        bge end_print_array_loop

        ldr r0, =outp
        mov r3, r10, LSL #2
        ldr r1, [r4, r3]

        bl printf

        add r10, r10, #1

        b print_array_loop

    end_print_array_loop:

    ldr r0, =newline
    bl printf

    sub sp, fp, #4
    pop {fp, pc}
