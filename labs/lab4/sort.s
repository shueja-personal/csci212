.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
MAX_INT: .word 0x7fffffff
.text
.align 2
.global sort_zeroes_up
.type sort_zeroes_up, %function



sort_zeroes_up:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of array[0]
    @ r1 = #elements

    @ r10 = i
    @ r9 = j
    mov r10, #0
    mov r9, #0
    sort_i_loop:
        cmp r10, r1
        bge end_sort_i_loop

        mov r9, 0

        sort_j_loop:
            sub r2, r1, 1
            cmp r9, r2
            bge end_sort_j_loop

            mov r3, r9, LSL #2  @ a[i]
            
            ldr r4, [r0, r3]
            add r3, r3, 4
            ldr r5, [r0, r3]
            sub r3, r3, 4

            cmp r4, 0
            ldreq r4, =MAX_INT
            ldreq r4, [r4]


            cmp r4, r5 @ swap if r4 is greater than r5
            ble else
            swap:
            @ swapping
            str r5, [r0, r3]
            add r3, r3, 4
            str r4, [r0, r3]
            sub r3, r3, 4

            else:
            add r9, r9, #1  @ j++

            b sort_j_loop

        end_sort_j_loop:

        add r10, r10, #1

        b sort_i_loop

    end_sort_i_loop:

    mov r10, 0
    cleanup_loop:
    
        cmp r10, r1
        bge end_cleanup_loop

        mov r3, r10, LSL #2  @ a[i]
        ldr r4, [r0, r3]
        ldr r2, =MAX_INT
        ldr r2, [r2]
        cmp r4, r2
        moveq r4, 0
        str r4, [r0, r3]
        add r10, r10, 1
        b cleanup_loop
    end_cleanup_loop:

    sub sp, fp, #4
    pop {fp, pc}
