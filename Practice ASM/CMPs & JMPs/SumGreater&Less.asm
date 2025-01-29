[org 0x0100]        ; Set code origin for COM file
jmp start            ; Jump to start of code to bypass the data

; Data Section
data:   db 5, 10, 8, 6, 11, 20  ; Array of numbers (6 values)
less:   db 0                    ; Variable to store sum of numbers < 12
greater: db 0                   ; Variable to store sum of numbers >= 12

; Main Program (Register + offset addressing)
start:
    mov bx, 0                  ; Set BX to 0 (index for data array)

loop1:
    mov al, [data+bx]          ; Load value from data array at index BX into AL
    cmp al, 12                 ; Compare value in AL with 12
    jb less_num                ; If AL < 12, jump to less_num (add to "less")
    
    add [greater], al          ; If AL >= 12, add value to "greater"
    inc bx                     ; Increment BX (move to next element)
    cmp bx, 6                  ; Check if we've processed all 6 elements
    jne loop1                  ; If not, continue looping

less_num:
    cmp bx, 6                  ; Check if we processed all data
    je exit                    ; If so, exit the program
    add [less], al             ; Add AL value (less than 12) to "less"
    inc bx                     ; Increment BX (move to next element)
    jmp loop1                  ; Jump to loop1 (continue processing)

exit:
    mov ax, 0x4c00             ; Exit the program (DOS interrupt)
    int 0x21                   ; DOS interrupt to terminate the program