.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
    computerGivesYouStr: .asciz "Gives you one %d\n"
    goFishStr: .asciz "Sorry, go fish.\n"
    emptyDeckStr: .asciz "Deck is empty!\n"
    youPickedUpStr: .asciz "Picked up a %d. \n"
    computerAsksYouStr: .asciz "Do you have a %d?\n"
    youGiveComputerStr: .asciz "Gives the computer one %d\n"
    computerPickedUpStr: .asciz "Picked up a card.\n"
    youWinStr: .asciz "You Win!\n"
    tieGameStr: .asciz "Tied Game!\n"
    computerWinsStr: .asciz "Computer Wins :(\n"
    out: .asciz "arr: %p fp: %p sp:%p \n"
.text
.equ COMPUTER_SCORE_PTR, -8
.equ PLAYER_SCORE_PTR, -12
.equ DECK, PLAYER_SCORE_PTR - (4*13) // 8 (fp, lr) + 8 (scores) + 13*4
.equ COMPUTER_HAND, DECK - (4*13) // 68+52
.equ PLAYER_HAND, COMPUTER_HAND - (4*13)
.align 2
.global main
.type main, %function

main:
    push {fp, lr}
    add fp, sp, 4 //sp = fp-4

    mov r0, 0
    bl time
    bl srand

    mov r0, 0
    push {r0}
    push {r0} //sp=fp-12

    sub sp, sp, 52*3 //156, sp = fp-168

    // init deck
    add r0, fp, DECK
    mov r1, 13
    mov r2, 4
    bl fillArray

    mov r3, sp
    mov r2, fp
    add r1, fp, DECK
    ldr r0, =out
    bl printf

    add r0, fp, COMPUTER_HAND
    mov r1, 13
    mov r2, 0
    bl fillArray

    add r0, fp, PLAYER_HAND
    mov r1, 13
    mov r2, 0
    bl fillArray


    add r0, fp, DECK
    add r1, fp, PLAYER_HAND
    bl deal

    add r0, fp, DECK
    add r1, fp, COMPUTER_HAND
    bl deal

    add r0, fp, PLAYER_HAND
    mov r1, 1
    add r2, fp, PLAYER_SCORE_PTR
    bl processPairs

    add r0, fp, COMPUTER_HAND
    mov r1, 0
    add r2, fp, COMPUTER_SCORE_PTR
    bl processPairs

    add r0, fp, PLAYER_HAND
    add r1, fp, PLAYER_SCORE_PTR
    add r2, fp, COMPUTER_SCORE_PTR
    bl print_hud
    
    main_loop:
        playerTurn:
        bl get_player_guess
        push {r0}

        add r0, fp, COMPUTER_HAND
        add r1, fp, PLAYER_HAND
        ldr r2, [sp]
        bl give
        cmp r0, 0
        bleq playerGoFish
        playerGetsCard:
            mov r0, 0
            bl print_prompt
            ldr r0, =computerGivesYouStr
            ldr r1, [sp]
            bl printf
            bl endPlayerTurn
        playerGoFish:
            mov r0, 0
            bl print_prompt
            ldr r0, =goFishStr
            bl printf
            add r0, fp, DECK
            add r1, fp, PLAYER_HAND
            bl draw
            cmp r0, 0
            bleq playerEmptyDeck
            blne playerDraw
            playerEmptyDeck:
                ldr r0, =emptyDeckStr
                bl printf
                bl endPlayerTurn
            playerDraw:
                push {r0}
                mov r0, 1
                bl print_prompt
                pop {r1}
                ldr r0, =youPickedUpStr
                bl printf
        endPlayerTurn:
            add r0, fp, PLAYER_HAND
            mov r1, 1
            add r2, fp, PLAYER_SCORE_PTR
            bl processPairs

            add r0, fp, PLAYER_HAND
            add r1, fp, PLAYER_SCORE_PTR
            add r2, fp, COMPUTER_SCORE_PTR
            bl print_hud

            pop {r0}
        computerTurn:
        bl rand
        mov r1, 13
        bl mod
        
        add r1, r1, 1
        // pick random number
        push {r0}
        mov r0, 0
        bl print_prompt
        ldr r1, [sp]
        ldr r0, =computerAsksYouStr
        bl printf

        add r0, fp, PLAYER_HAND
        add r1, fp, COMPUTER_HAND
        ldr r2, [sp]
        bl give
        cmp r0, 0
        bleq computerGoFish
        computerGetsCard:
            mov r0, 1
            bl print_prompt
            ldr r0, =youGiveComputerStr
            ldr r1, [sp]
            bl printf
            bl endComputerTurn
        computerGoFish:
            mov r0, 1
            bl print_prompt
            ldr r0, =goFishStr
            bl printf
            add r0, fp, DECK
            add r1, fp, COMPUTER_HAND
            bl draw
            cmp r0, 0
            bleq computerEmptyDeck
            blne computerDraw
            computerEmptyDeck:
                ldr r0, =emptyDeckStr
                bl printf
                bl endComputerTurn
            computerDraw:
                push {r0}
                mov r0, 0
                bl print_prompt
                pop {r1}
                ldr r0, =computerPickedUpStr
                bl printf
        endComputerTurn:
            add r0, fp, COMPUTER_HAND
            mov r1, 0
            add r2, fp, COMPUTER_SCORE_PTR
            bl processPairs

            add r0, fp, PLAYER_HAND
            add r1, fp, PLAYER_SCORE_PTR
            add r2, fp, COMPUTER_SCORE_PTR
            bl print_hud  

            ldr r1, [fp, PLAYER_SCORE_PTR]
            ldr r2, [fp, COMPUTER_SCORE_PTR]
            add r1, r1, r2
            cmp r1, 26
            bge end_main_loop

    b main_loop
    end_main_loop:

        ldr r1, [fp, PLAYER_SCORE_PTR]
        ldr r2, [fp, COMPUTER_SCORE_PTR]
        cmp r1, r2
        ldrpl r0, =youWinStr
        ldreq r0, =tieGameStr
        ldrmi r0, =computerWinsStr
        bl printf
        mov r0, 0     

    sub sp, fp, 4
    pop {fp, pc}

    
    