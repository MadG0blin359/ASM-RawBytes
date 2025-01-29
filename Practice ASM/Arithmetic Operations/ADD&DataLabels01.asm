[org 0x0100]            ; Set the code origin at offset 0x100 for COM execution

mov ax, [num1]          ; Load the value at memory location 'num1' into AX (AX = 5)
mov bx, [num2]          ; Load the value at memory location 'num2' into BX (BX = 10)
add ax, bx              ; Add the value in BX to AX (AX = AX + 10)

mov bx, [num3]          ; Load the value at memory location 'num3' into BX (BX = 15)
add ax, bx              ; Add the value in BX to AX (AX = AX + 15)

mov [num4], ax          ; Store the final result in memory location 'num4'

mov ax, 0x4c00          ; Terminate program with DOS interrupt, AL = 0 for successful termination
int 0x21                ; Call DOS interrupt to exit the program

num1: dw 5              ; Define word data for num1 with value 5
num2: dw 10             ; Define word data for num2 with value 10
num3: dw 15             ; Define word data for num3 with value 15
num4: dw 0              ; Reserve word data for num4 (initialized to 0)