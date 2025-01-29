[org 0x0100]            ; Set the origin for code execution at offset 0x100 for COM file

mov ax, 5               ; Load the value 5 into the AX register
mov bx, 3               ; Load the value 3 into the BX register
mov cx, ax              ; Copy the value in AX to the CX register
add cx, bx              ; Add the value in BX to CX (CX = 5 + 3 = 8)

mov ax, 0x4c00          ; Termination function for DOS (INT 21h), setting AL = 0 for success
int 21h                 ; Call DOS interrupt to terminate the program