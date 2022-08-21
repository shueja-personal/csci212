
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
    out: .asciz "Checking %d\n"
    laysPair: .asciz "Lays down a pair of %ds.\n"
.text
.align 2
.global checkAllPairs
.type checkAllPairs, %function
.global processPairs
.type processPairs, %function


checkPair:
    push {fp, lr}
    add fp, sp, 4
    @ ldr r0, =out
    @ bl printf
    @ mov r0, 0
    mov r2, r0 // save the addr
    mov r0, 0 // set up return value
    mov r3, r1, LSL #2 // calc offset
    ldr r1, [r2, r3] // load
    cmp r1, 2 //compare

    subge r1, r1, 2 //subtract
    strge r1, [r2, r3] // store
    movge r0, 1 //set return val
    end:
    sub sp, fp, 4
    pop {fp, pc}

checkAllPairs:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = address of deck
    mov r3, 0
    push {r0, r3} // addr, i


    checkAllPairs_loop:
        ldr r1, [fp, -8]// i
        cmp r1, 13
        movge r0, 0 // if we got to the end, return 0
        bge end_checkAllPairs_loop

        ldr r0, [fp, -12] //adr
        ldr r1, [fp, -8] // i
        
        bl checkPair
        cmp r0, 1 // if a pair (it's already been removed by checkPair)
        ldreq r1, [fp, -8] // load i
        addeq r0, r1, 1 @ errorCode = i+1
        beq end_checkAllPairs_loop
        //i++
        ldr r1, [fp, -8]
        add r1, r1, 1
        str r1, [fp, -8]

        b checkAllPairs_loop

    end_checkAllPairs_loop:
    sub sp, fp, #4
    pop {fp, pc}

processPairs:
    push {fp, lr}
    add fp, sp, 4
    push {r0, r1, r2} // score (-8), player (-12), hand(-16)
    process_loop:
        // check all pairs and print messages for the ones found
        ldr r0, [fp, -16]
        bl checkAllPairs
        cmp r0, 0
        
        beq process_end
        push {r0} // save the pair that was found
        ldr r0, [fp, -12]
        bl print_prompt
        pop {r1}
        ldr r0, =laysPair
        bl printf
        // increment score
        ldr r1, [fp, -8]
        ldr r0, [r1]
        add r0, r0, 1
        str r0, [r1]

        b process_loop

    process_end:
    sub sp, fp, 4
    pop {fp, pc}

