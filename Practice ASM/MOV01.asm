org 0x100             ; Set the origin for code execution to 0x100 for COM file format

mov ax, 1234H          ; Move hexadecimal value 1234H into AX register
mov bx, 1234           ; Move decimal value 1234 into BX register
mov cx, -1234H         ; Move signed hexadecimal value -1234H into CX register
mov dx, -1234          ; Move signed decimal value -1234 into DX register
mov ax, 1011011B       ; Move binary value 1011011B into AX register
mov ah, 'B'            ; Move ASCII character 'B' into the higher byte of AX (AH)
mov al, 'd'            ; Move ASCII character 'd' into the lower byte of AX (AL)

mov ax, 0x4c00         ; Move exit code 0x4c00 into AX for program termination
int 0x21              ; DOS interrupt to terminate the program