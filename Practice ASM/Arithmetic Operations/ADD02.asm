[org 0x0100]            ; Set code origin at offset 0x100 for COM file execution

mov AX, 0x1254          ; Load the hexadecimal value 0x1254 into the AX register
mov BX, 0x0FFF          ; Load the hexadecimal value 0x0FFF into the BX register
add ax, 0xEDAB          ; Add the hexadecimal value 0xEDAB to the current value of AX
add ax, bx              ; Add the current value of BX to AX
add bx, 0xF001          ; Add the hexadecimal value 0xF001 to BX

mov ax, 0x4c00          ; Terminate program with DOS interrupt, AL = 0 for successful termination
int 21h                 ; Call DOS interrupt to end the program