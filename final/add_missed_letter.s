.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
.text
.align 2
.global add_missed_letter
.type add_missed_letter, %function

add_missed_letter:
    push {fp, lr}
    add fp, sp, 4
    mov r3, 0
    @ r0 - array of missed letters
    @ r1 - character to add
    loop:

        cmp r3, 7 // have we reached the end of the missed letters list
        movge r0, 0
        bge end
        ldrsb r2, [r0, r3] // if not, load from the index

        cmp r2, '\0 // is it null? end
        beq end

        cmp r2, r1 // is it equal to the one we want to add?
        beq end // if yes, end

        cmp r2, '- // is it a dash
        strbeq r1, [r0, r3] // store the character by replacing the dash
        beq end
        add r3, r3, 1
        b loop
    end:
    mov r0, 0
    sub sp, fp, 4
    pop {fp, pc}

