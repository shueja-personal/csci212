@ int pick_random_word(char *buffer) {
@     FILE *ptr;
@     ptr = fopen("dictionary.txt", "r");
@     int numWords = 0;
@     fscanf (ptr, "%d", &numWords);
@     int idx = rand() % numWords;
@     idx++;
@     int i = 0;
@     while(1) {
@         if(i >= idx) {
@             break;
@         }
@         fscanf(ptr, "%s", buffer);
@         i++;
@     }
@     int j = 0;
@     while(1) {
@         if (j == 15) break;
@         if (buffer[j] == '\0') break;
@         j++;
@     }
    
@     fclose(ptr);
@     return j;

@ }

.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
filename: .asciz "dictionary.txt"
mode: .asciz "r"
numScan: .asciz "%d"
wordScan: .asciz "%s"
charScan: .asciz "%c"
errorOpen: .asciz "Error opening file!\n"
.text
.equ BUFFER_PTR, -8
.equ FILE_PTR, BUFFER_PTR -4
.equ NUM_WORDS, FILE_PTR -4
.equ IDX, NUM_WORDS -4
.equ ITER, IDX-4
.align 2
.global pick_random_word
.type pick_random_word, %function

pick_random_word:
    push {fp, lr}
    add fp, sp, 4
    push {r0} // bufferptr = fp -8

    // open file
    openFile:
    ldr r0, =filename
    ldr r1, =mode
    bl fopen
    push {r0} // fptr = fp -12
    // if no error, go to scanning
    cmp r0, 0
    blne scanNumWords
    // if error, print error and exit
    ldr r0, =errorOpen
    bl printf
    bl exit
    scanNumWords:
    // scan the first line to see how many words are in the list
    mov r2, 0
    push {r2} 
    ldr r1, =numScan
    add r2, fp, NUM_WORDS
    bl fscanf
    // generate a random number
    bl rand
    ldr r1, [fp, NUM_WORDS]
    bl mod
    
    add r3, r0, 1 // idx in r3
    // loop that random # of times, overwriting the output buffer each time
    push {r3}
    mov r2, 0 // iterator in r2
    push {r2}
    scan_loop:
        //condition
        ldr r3, [fp, IDX]
        ldr r2, [fp, ITER]
        cmp r2, r3
        bge end_scan_loop
        // scan
        ldr r0, [fp, FILE_PTR]
        ldr r1, =wordScan
        ldr r2, [fp, BUFFER_PTR]
        bl fscanf
        // increment
        ldr r2, [fp, ITER]
        add r2, r2,1
        str r2, [fp, ITER]


        b scan_loop
    end_scan_loop:
    // close file
    ldr r0, [fp, FILE_PTR]
    bl fclose
    mov r2, 0
    str r2, [fp, ITER]

    // count the length of the word
    count_loop:
        mov r3, 15
        ldr r2, [fp, ITER]
        cmp r2, r3
        bge end_count_loop
        ldr r1, [fp, BUFFER_PTR] // load the pointer out of stack
        ldrb r1, [r1, r2] // load offset from buffer

        cmp r1, 0
        beq end_count_loop
        ldr r2, [fp, ITER]
        add r2, r2,1
        str r2, [fp, ITER]
        b count_loop
    end_count_loop:
    ldr r0, [fp, ITER]
    cleanup:
    sub sp, fp, 4
    pop {fp, pc}
    




