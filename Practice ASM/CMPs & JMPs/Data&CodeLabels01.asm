[org 0x0100]
jmp start

num1: db 2
num2: db 3

start:	inc byte [num1]
	inc byte [num2]

mov al, [num1]
add al, [num2]

mov ax, 0x4c00
int 21h