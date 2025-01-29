[org 0x0100]

mov ax, 0xDF01   ; Move immediate value DF01H into AX
add ax, 0xA010   ; Add immediate value A010H to AX

mov ax, 0x4c00  ; Terminate program (return code 0) and exit to DOS
int 21h         ; DOS interrupt