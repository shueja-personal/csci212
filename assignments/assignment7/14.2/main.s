@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax
        .data
        prompt: .asciz "Enter some text: "
        infmt: .asciz "%s"
        newline: .asciz "\n"
@ Program code
        .text
        .align  2
        .global main
        .type   main, %function

# compile with gcc *.s

main:
        push    {fp, lr}        @push the frame pointer and link register of the containing stack frame to the stack
        add     fp, sp, 4
        push    {r4}      
        mov     r0, 50
        bl malloc
        mov     r4, r0
        ldr     r0, =prompt
        bl printf
        ldr     r0, =infmt
        mov     r1, r4
        bl scanf
        mov     r0, r4
        bl to_lowercase
        ldr     r0, =infmt
        mov     r1, r4
        bl printf
        ldr     r0, =newline
        bl printf
        mov r0, r4
        b free
        pop     {r4}
        sub     sp, fp, 4
        pop     {fp, pc}

to_lowercase:
        push {fp, lr}
        add fp, sp, 4
        push    {r4}
        mov r4, r0
        loop:
                ldrb r3, [r4]
                cmp r3, 0
                beq end_loop

                orr r3, 32
                strb r3, [r4]
                add r4, r4, 1
                b loop
        end_loop:
        add sp, fp, -8
        pop {r4}
        pop {fp, pc}


