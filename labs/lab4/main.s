@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

        .equ NUM_DECKS_PTR, -12
        .equ ARR_PTR_PTR, -8

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function

# compile with gcc *.s

main:
        push    {fp, lr}        @push the frame pointer and link register of the containing stack frame to the stack
        add     fp, sp, 4       @ set our frame pointer relative to the stack pointer 
        # (producing a record of where our stack pointer was when we entered this function, sp = fp-4)
        # because we're now going to move the stack pointer to give ourselves some memory to work with
        # stack: [array cont], #decks, arrayPtr, 
        # array ptr and #decks
        # arrPtr @ fp-8
        # numDecks @ fp-12
        # sp = fp-12
        sub     sp, sp, 8
        # array contents, 46 deck slots * 4 bytes = 184 bytes
        sub     sp, sp, 184
        # sp is now at the ptr of the 0th element of our array, so we store sp into arrPtr at fp-8
        str     sp, [fp, ARR_PTR_PTR]
        # Our number of decks (that actually contain cards) starts at 0
        mov     r0, 0
        str     r0, [fp, NUM_DECKS_PTR]

        # we need to call init decks with r0 being arrPtr addr, r1 being numDecks addr
        ldr     r0, [fp, ARR_PTR_PTR]
        add     r1, fp, NUM_DECKS_PTR
        bl      init_decks

        @ print array (r1 is the actual number of decks, not the address)
        ldr r0, [fp, ARR_PTR_PTR]
        ldr r1, [fp, NUM_DECKS_PTR]
        bl      print_array

        solitaire_step_loop:
                ldr r0, [fp, ARR_PTR_PTR]
                bl check_success
                cmp r0, 1
                bleq end_solitaire_step_loop

                ldr r0, [fp, ARR_PTR_PTR]
                add     r1, fp, NUM_DECKS_PTR
                bl      solitaire

                ldr r0, [fp, ARR_PTR_PTR]
                ldr r1, [fp, NUM_DECKS_PTR]
                bl      print_array
                b solitaire_step_loop

        end_solitaire_step_loop:

        mov     r0, 0           @ return flag;

        sub     sp, fp, 4 @ jump the sp back to where it was before we allocated
        # , by using the value of fp (we don't need to add that 8 and 184 back manually)
        pop     {fp, pc} @ pop fp back into fp, and pop lr directly to pc (doing the same thing as bx lr)
        @ ldr     fp, [sp, 0]     @ restore caller fp
        @ ldr     lr, [sp, 4]     @       lr
        @ add     sp, sp, 8       @   and sp
        @ bx      lr              @ return
