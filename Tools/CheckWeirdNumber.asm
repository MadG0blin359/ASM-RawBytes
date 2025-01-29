[org 0x0100]           ; Set code origin at 0x100 for COM execution
jmp start              ; Jump to the start label to bypass data definitions

; Data Definitions
weird:                  db 'WEIRD NUMBER', 0      ; Store the string "WEIRD NUMBER"
weird_Length:           db 12                     ; Length of the string "WEIRD NUMBER"
not_weird:              db 'NOT A WEIRD NUMBER', 0 ; Store the string "NOT A WEIRD NUMBER"
not_weird_Length:       db 18                     ; Length of the string "NOT A WEIRD NUMBER"
sum:                    db 0                      ; Initialize sum variable
input:                  dw 0                      ; Input buffer (16-bit number)

; Clear Screen Subroutine (clrscr)
clrscr:
    push es
    push di
    push ax
    push cx
    
    mov ax, 0xb800          ; Set video segment address (text video memory)
    mov es, ax
    xor di, di              ; Set DI register to 0 (start of screen)
    
    mov ax, 0x0720          ; Character and attribute (light grey on black)
    mov cx, 2000            ; Screen size (2000 words for 80x25 text mode)
    
    cld                     ; Clear direction flag for string operations
    rep stosw               ; Repeat storing word in ES:DI (clear screen)
    
    pop cx
    pop ax
    pop di
    pop es
    
    ret

; Get Input Subroutine (Get_Input)
Get_Input:
    push ax
    push bx
    push cx
    
    xor ax, ax               ; Clear AX register (set to 0)
    mov bx, 10               ; Set BX to 10 (base 10 for number input)
    mov cx, 1                ; Set CX to 1 (max 16-bits, 5 digits + Enter)
    
input_loop:
    xor ax, ax               ; Clear AX register for the input
    int 16h                  ; Call keyboard interrupt (read key from keyboard)
    
    cmp al, 13               ; Compare AL to ASCII for Enter key (13)
    je exit_input            ; If Enter key is pressed, exit input loop
    
    sub al, '0'              ; Convert ASCII character to numeric value
    cmp al, 9                ; Check if AL is a valid digit (0-9)
    ja input_loop            ; If not, continue loop and wait for valid input
    
    add [input], ax          ; Add value of AL to input variable
    
    mov ax, [input]          ; Load input into AX
    mul bx                   ; Multiply AX by BX (base 10)
    mov [input], ax          ; Store result back in input buffer
    
    jmp input_loop           ; Repeat input loop
    
exit_input:
    mov ax, [input]          ; Load input into AX
    mov bx, 10               ; Set BX to 10 (divide by 10 to get final value)
    div bx                   ; AX divided by BX, result in AX
    mov [input], ax          ; Store result back in input buffer
    
    pop cx
    pop bx
    pop ax
    
    ret

; Get Divisors Subroutine (Get_Divisor)
Get_Divisor:
    push ax
    push bx
    push cx
    push dx
    
    mov bx, 10               ; Set BX to 10 for divisors
    mov cx, 1                ; Set CX to 1 for starting divisor
    mov dx, [input]          ; Load input number into DX
    shr dx, 1                ; Right shift DX by 1 (divide by 2)
    
loop_divisor:
    mov ax, [input]          ; Load input into AX
    div bx                   ; Divide AX by BX
    xor dx, dx               ; Clear DX for next division
    div cx                   ; Divide AX by CX (start with 1)
    
    cmp dx, 0                ; Check if remainder is 0 (if divisible)
    jne not_divisior         ; If not divisible, continue to next divisor
    
    add [sum], cx            ; Add divisor (CX) to sum
    
not_divisior:
    inc cx                   ; Increment divisor (CX)
    
    cmp cx, dx               ; Compare divisor (CX) to the result of DX
    jle loop_divisor         ; If divisor is <= DX, continue loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret

; Display Message Subroutine (Display_Msg)
Display_Msg:
    push bp
    mov bp, sp
    
    push es
    push ax
    push bx
    push cx
    push si
    
    mov ah, 13h              ; Set AH to 13h (set text mode)
    mov al, 1                ; Set AL to 1 for text color
    mov bh, 0                ; Set BH to 0 for video page
    mov bl, 0x0f             ; Set BL to 0x0f for white text
    mov cx, [bp+4]           ; Load the message length from the stack
    push ds                  ; Save data segment
    pop es                   ; Set ES to the data segment
    
    mov si, [bp+6]           ; Load message address from stack
    push bp
    mov bp, si
    
    int 10h                  ; Call BIOS interrupt to display the message
    
    pop bp
    
    pop si
    pop cx
    pop bx
    pop ax
    pop es
    pop bp
    
    ret 4                    ; Clean up the stack and return

; Main Program Start
start:
    ;call clrscr                ; Clear the screen (optional)
    
    call Get_Input            ; Call Get_Input to get user input
    ;call Get_Divisor         ; Uncomment if you want to use the divisor calculation
    ;call Display_Msg         ; Uncomment to display a message based on logic
    
Exit:
    mov ax, 0x4c00           ; Set AH=4Ch (program exit)
    int 0x21                 ; Call DOS interrupt to terminate the program