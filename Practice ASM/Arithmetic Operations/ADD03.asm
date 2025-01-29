[org 0x0100]            ; Set code origin at offset 0x100 for COM file execution

mov ax, 2               ; Load the value 2 into the AX register
add ax, ax              ; Double the value in AX (AX = AX + AX)

mov bx, 3               ; Load the value 3 into the BX register
add bx, 3               ; Add 3 to the current value of BX (BX = BX + 3)
add bx, 3               ; Add 3 again to BX (BX = BX + 3)

add ax, bx              ; Add the current value of BX to AX

mov ax, 0x4c00          ; Terminate program with DOS interrupt, AL = 0 for successful termination
int 21h                 ; Call DOS interrupt to end the program