[org 0x0100]
jmp start

multiplicand: dw 17         ; The number to multiply
multiplier:   db 6          ; The number to multiply by
result:      dw 0           ; Result storage (word)

start:
    mov cl, 8               ; Counter for 8 bits
    mov ax,0              ; Clear AX (for storing multiplicand into AL)
    mov bl, [multiplier]               ; Bitmask for checking bits of multiplier

checkbit:
    shr byte bl, 1    ; Test the current bit of the multiplier
    jnc skip
    mov ax, [multiplicand]   ; Load multiplicand into AL
   
    add [result], ax         ; Add AX (16-bit value) to result

skip:
    shl byte [multiplicand], 1 ; Shift multiplier left by 1 bit
    dec cl                   ; Decrease bit counter
    jnz checkbit             ; Repeat if CL is not zero

    mov ax, 0x4c00           ; Exit program
    int 0x21