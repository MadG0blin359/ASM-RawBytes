[org 0x0100]
jmp start

num1:	db 19
num2:	db 26

start:	mov al, [num1]
		mov bl, [num2]
		
		and al, bl				; Perform bitwise AND on AL and BL, store result in AL
		
		mov ax, 0x4c00			; Terminate Program
		int 0x21