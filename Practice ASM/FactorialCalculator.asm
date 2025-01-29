[org 0x0100]            ; Set code origin at offset 0x100 for COM execution  
jmp start               ; Jump to the start label to bypass data definitions

num: db 0               ; Declare a byte to store the input number (uninitialized)  
factorial: db 0         ; Declare a byte to store the computed factorial result

; Direct Addressing Mode
start:  
    mov al, 0           ; Initialize AL to 0 (used for intermediate sum operations)  
    mov bl, [num]       ; Load the value of num into BL  
    mov cl, 0           ; Initialize CL to 0  
    mov dl, bl          ; Copy BL to DL for initial multiplication setup  

outer_loop:  
    mov cl, bl          ; Load BL (current counter value) into CL  
    dec cl              ; Decrement CL by 1  
    cmp cl, 0           ; Check if CL is less than or equal to 0  
    jle result          ; If CL <= 0, jump to the result

inner_loop:  
    add al, dl          ; Add DL (intermediate result) to AL  
    dec cl              ; Decrement CL  
    jnz inner_loop      ; Repeat inner loop until CL becomes 0  

    mov dl, al          ; Store the accumulated value in DL  
    mov al, 0           ; Reset AL to 0 for the next iteration  
    dec bl              ; Decrement BL (counter)  
    cmp bl, 0           ; Check if BL is 0  
    jne outer_loop      ; If BL is not 0, continue outer loop  

zero_factorial:  
    mov dl, 1           ; Set DL to 1 if factorial is zero (0! = 1)  

result:  
    cmp dl, 0           ; Check if DL is 0  
    je zero_factorial   ; Jump to set DL to 1 for 0!  

    mov [factorial], dl ; Store the computed factorial in memory  

mov ax, 0x4c00          ; Terminate program with DOS interrupt  
int 0x21                ; Call DOS interrupt to exit the program