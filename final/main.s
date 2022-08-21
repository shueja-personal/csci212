.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
    wrongAnswerStr: .asciz ">>>BZZ! Wrong<<<\n"
    youLoseStr: .asciz "You Lose! It was %s.\n"
    youWinStr: .asciz "You Win!\n"
    newline: .asciz "\n"
    charScan: .asciz "%c"

.text
.equ WORD_PTR, -8 - 16
.equ GUESS_WORD_PTR, WORD_PTR - 16
.equ MISSED_PTR, GUESS_WORD_PTR - 8
.equ HANGMAN_PTR, MISSED_PTR - 8
.equ CHAR_PTR, HANGMAN_PTR - 4
.align 2
.global main
.type main, %function

main:
    push {fp, lr}
    add fp, sp, 4 //sp = fp-4

    mov r0, 0
    bl time
    bl srand

    sub sp, sp, 8 + 16 + 16 + 8 + 8 // 56

    // fill word array
    add r0, fp, WORD_PTR
    mov r1, 16
    mov r2, 0
    bl fillByteArray

    // fill guess word array with null
    add r0, fp, GUESS_WORD_PTR
    mov r1, 16
    mov r2, 0
    bl fillByteArray

    // pick random word
    add r0, fp, WORD_PTR
    bl pick_random_word
    // r0 now has the word length
    // fill the first 'wordlength' slots with dashes
    mov r1, r0
    add r0, fp, GUESS_WORD_PTR
    mov r2, '-
    bl fillByteArray

    @ @ // Missed letters
    add r0, fp, MISSED_PTR
    mov r1, 0
    strb r1, [r0, 7] // store the final null
    mov r1, 7 // fill the rest with dashes
    mov r2, '-
    bl fillByteArray

    @ @ // Missed letters
    add r0, fp, HANGMAN_PTR
    mov r1, 0
    strb r1, [r0, 7] // store the final null
    mov r1, 7 // fill the rest with dashes
    mov r2, '-
    bl fillByteArray

    add r0, fp, GUESS_WORD_PTR
    add r1, fp, HANGMAN_PTR
    add r2, fp, MISSED_PTR
    bl print_status

    mov r0, 0
    push {r0}
    main_loop:
        add r0, fp, CHAR_PTR
        bl get_player_guess
        // get guess, print newline
        ldr r0, =newline
        bl printf

        // search and replace that guess in the word
        add r0, fp, WORD_PTR
        add r1, fp, GUESS_WORD_PTR
        ldr r2, [fp, CHAR_PTR]
        bl find_replace
        cmp r0, 0 //nonzero means letter was not found,
        // if it was 0, go to status
        beq status
        // print wrong answer string and add another letter to hangman
        ldr r0, =wrongAnswerStr
        bl printf
        add r0, fp, HANGMAN_PTR
        bl advance_hangman
        cmp r0, 0
        // player loses if hangman is full (advance_hangman returns 0)
        ldreq r0, =youLoseStr
        addeq r1, fp, WORD_PTR
        bleq printf
        bleq end_main_loop
        // add the missed letter
        add r0, fp, MISSED_PTR
        ldr r1, [fp, CHAR_PTR]
        bl add_missed_letter

        status:
            add r0, fp, GUESS_WORD_PTR
            add r1, fp, HANGMAN_PTR
            add r2, fp, MISSED_PTR
            bl print_status

        add r0, fp, WORD_PTR
        add r1, fp, GUESS_WORD_PTR
        bl check_success
        // if the word matches the guess word, you win
        ldreq r0, =youWinStr
        bleq printf
        bleq end_main_loop
        
        b main_loop

    end_main_loop:


    sub sp, fp, 4
    pop {fp, pc}

    
    