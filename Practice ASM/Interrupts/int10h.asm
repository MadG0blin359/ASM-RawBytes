[org 0x0100]           ; Set code origin at offset 0x100 for COM execution  
jmp start              ; Jump to start to bypass data definitions

start:  
    mov ah, 0          ; Clear AH (set to 0)
    mov al, 3          ; Set AL to 3 for mode 3 (video mode 3: 80x25 color text)
    int 10h            ; Call BIOS interrupt 10h to set video mode  

    xor ax, ax         ; Clear AX register (set to 0)
    int 16h            ; Call BIOS interrupt 16h for keyboard input  

    cmp al, 0x61       ; Compare the character in AL to ASCII value for 'a' (0x61)  
    jl skip            ; If AL is less than 'a', skip the next operation  

    sub al, 0x20       ; If AL is >= 'a', convert it to uppercase by subtracting 0x20 (ASCII difference)  

skip:  
    mov ah, 09h        ; Set AH to 09h for "Display String" function of INT 10h  
    mov bh, 0          ; Set BH to 0 for page number (video memory page)  
    mov bl, 0x0f       ; Set BL to 0x0f for white text on black background  
    mov cx, 3          ; Set CX to 3 for the length of string to be displayed  
    int 10h            ; Call BIOS interrupt 10h to display the string  

    mov ax, 0x4c00     ; Prepare for program termination (AH=4Ch, AL=00h for normal exit)
    int 21h            ; Call DOS interrupt 21h to terminate the program