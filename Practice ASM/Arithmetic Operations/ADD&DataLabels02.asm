[org 0x0100]            ; Set the code origin at offset 0x100 for COM execution

mov ax, [num]           ; Load the first word (num = 5) into AX
mov bx, [num+2]         ; Load the second word (num+2 = 10) into BX
add ax, bx              ; Add BX to AX (AX = AX + 10)

mov bx, [num+4]         ; Load the third word (num+4 = 15) into BX
add ax, bx              ; Add BX to AX (AX = AX + 15)

mov [num+6], ax         ; Store the result in the fourth word (num+6) as the sum of num, num+2, and num+4

mov ax, 0x4c00          ; Terminate program with DOS interrupt, AL = 0 for successful termination
int 0x21                ; Call DOS interrupt to exit the program

num: dw 5               ; Define the first word as 5
dw 10                   ; Define the second word as 10
dw 15                   ; Define the third word as 15
dw 0                    ; Define the fourth word as 0 (placeholder for the result)